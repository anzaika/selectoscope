ActiveAdmin.register Group do
  config.per_page = 10
  permit_params :id,
                :pattern,
                :tree_id,
                :fasta,
                :user_id,
                fasta_file_attributes: [:file]

  scope :all

  index download_links: false do
    selectable_column
    # column "tree" do |group|
    #   if group.tree
    #     render(partial: "groups/tnt_tree",
    #            locals:  {tree:    group.tree.newick,
    #                      width:   "400",
    #                      compact: true})
    #   end
    # end
    # column :alignment do |g|
    #   render "job_status", job: g.alignment_job
    # end
    # column :tree do |g|
    #   render "job_status", job: g.tree_job
    # end
    # column :codeml do |g|
    #   render "job_status", job: g.codeml_job
    # end
    # column :fast do |g|
    #   render "job_status", job: g.fast_job
    # end
    actions
  end

  filter :batch, collection: -> { Batch.all }
  filter :identifiers_name

  form html: {multipart: true} do |f|
    f.semantic_errors
    f.inputs "Fasta", for: [:fasta_file_attributes, f.object.fasta_file || FastaFile.new] do |ff|
      ff.input :file, as: :file
    end
    actions
  end

  show { render "group" }

  action_item(:run_full_stack, only: :show) do
    link_to("Run full stack", run_full_stack_group_path(resource), method: :post)
  end

  action_item(:clear_results, only: :show) do
    link_to("Clear results", clear_results_group_path(resource), method: :post)
  end

  member_action :run_full_stack, method: :post do
    Group::FullStackJob.perform_async(resource.id)
    redirect_to request.referrer, notice: "Full stack job submitted."
  end

  member_action :clear_results, method: :post do
    Group::ClearPipelineResultsJob.perform_async(resource.id)
    redirect_to request.referrer, notice: "All results have been queued for removal."
  end

  batch_action "add run profile",
               form: -> { {"run_profile" => RunProfile.all.pluck(:name, :id)} } do |ids, inputs|
    ids.each do |id|
      RunProfileGroupLink.create(group_id: id, run_profile_id: inputs["run_profile"])
    end
    redirect_to request.referrer, notice: "Run profile: #{RunProfile.find(inputs["run_profile"]).name} has been successfully added to #{ids.count} groups"
  end

  controller do
    def create
      @group = Group.new(permitted_params["group"])
      @group.user_id = current_user.id
      if @group.save
        redirect_to @group
      else
        flash[:errors] = @group.errors.messages
        render("new")
      end
    end
  end
end
