ActiveAdmin.register Batch do
  permit_params :id,
                :name,
                :description,
                :user_id,
                fasta_files: []

  index download_links: false do
    selectable_column
    column :name
    column "description" do |batch|
      truncate(batch.description, length: 70)
    end
    column "count_groups", sortable: "groups_count"
    actions
  end

  filter :name
  filter :description

  form partial: "form"

  show do |batch|
    columns do
      column span: 1 do
        panel "Basic info" do
          attributes_table_for batch do
            row :name
            row :description
            row :groups_count
          end
        end
      end
      column span: 1 do
        panel "Groups" do
          table_for batch.groups do
            column "sequences" do |group|
              a href: group_path(group) do
                div group.sequences.count
              end
            end
            column "sequences" do |group|
              group.sequences.count
            end
          end
        end
      end
    end
  end

  action_item :run_full_stack_for_all, only: :show do
    link_to("Run full-stack for all groups", run_full_stack_batch_path(resource))
  end

  member_action :run_full_stack, method: :get do
    resource.run_full_stack
  end

  batch_action 'Generate alignments for' do |ids|
    Batch.find(ids).each{|b| b.groups.each{|g| AlignmentForGroupJob.perform_later(g.id)}}
    Batch.find(ids).each{|b| b.groups.each{|g| GblocksForGroupJob.perform_later(g.id)}}
    redirect_to collection_path
  end

  batch_action 'Generate trees for' do |ids|
    Batch.find(ids).each{|b| b.groups.each{|g| PhymlForGroupJob.perform_later(g.id)}}
    redirect_to collection_path
  end

  batch_action 'Run codeml on' do |ids|
    Batch.find(ids).each{|b| b.groups.each{|g| CodemlForGroupJob.perform_later(g.id)}}
    redirect_to collection_path
  end

  batch_action 'Run fastcodeml on' do |ids|
    Batch.find(ids).each{|b| b.groups.each{|g| FastForGroupJob.perform_later(g.id)}}
    redirect_to collection_path
  end

  controller do
    def create
      @batch = Batch.new(
        name:        permitted_params["batch"]["name"],
        description: permitted_params["batch"]["description"],
        user_id:     current_user.id
      )
      if @batch.save
        if permitted_params["batch"]["fasta_files"]
          permitted_params["batch"]["fasta_files"].each do |f|
            fasta = FastaFile.new(file: f.tempfile)
            @batch.groups.create(fasta_file: fasta)
          end
        end
      end
      redirect_to resource_path(@batch.id)
    end

    def run_full_stack
      ids = Batch.find(params[:id]).groups.pluck(:id)
      ids.each {|id| AlignmentForGroupJob.perform_async(id) }
      ids.each {|id| GblocksForGroupJob.perform_later(id) }
      ids.each {|id| PhymlForGroupJob.perform_later(id) }
      ids.each {|id| CodemlForGroupJob.perform_later(id) }
      ids.each {|id| FastForGroupJob.perform_later(id) }
      redirect_to resource_path(resource.id)
    end
  end
end
