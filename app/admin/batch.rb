ActiveAdmin.register Batch do
  permit_params :id,
                :name,
                :description,
                :user_id,
                fasta_files: []

  index download_links: false do
    selectable_column
    column :name
    column "Description" do |batch|
      truncate(batch.description, length: 70)
    end
    column "Groups", sortable: "groups_count" do |batch|
      batch.count_groups
    end
    column "Groups with positive (cnt)" do |batch|
      batch.count_groups_with_positive
    end
    column "Groups with positive (%)" do |batch|
      batch.percent_of_groups_with_positive
    end
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
      column span: 2 do
        panel "Groups" do
          a href: "/groups?utf8=✓&q%5Bbatch_id_eq%5D=#{batch.id}&commit=Filter&order=id_desc" do
            div "Open in Groups view"
          end
          table_for batch.groups do
            column "Link" do |group|
              a href: group_path(group) do
                div group.name
              end
            end
            column :positive_selection do |group|
              if group.fast_result && group.fast_result.has_positive
                status_tag "yes"
              elsif group.fast_result && !group.fast_result.has_positive
                status_tag "no"
              else
                "---"
              end
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
    redirect_to request.referrer, notice: "Job has been successfuly submited"
  end

  batch_action 'Run full stack on' do |ids|
    Batch.find(ids).each{|b| Batch::FullStackForAllGroupsJob.perform_async(b.id) }
    redirect_to request.referrer, notice: "Job has been successfuly submited"
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
            fasta = FastaFile::AsUpload.new(file: f.tempfile)
            @batch.groups.create(fasta_file: fasta, user_id: current_user.id)
          end
        end
      end
      redirect_to resource_path(@batch.id)
    end

    def run_full_stack
      Batch::FullStackForAllGroupsJob.perform_async(params[:id])
      redirect_to resource_path(resource.id)
    end
  end
end
