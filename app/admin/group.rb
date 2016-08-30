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
    column :name
    column :batch
    column :sequences do |group|
      group.group_identifier_links.count
    end
    column :profiles do |group|
      group.profiles.map(&:name).join(", ")
    end
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

  form html: {multipart: true} do |f|
    f.semantic_errors
    f.inputs "Fasta", for: [:fasta_file_attributes, f.object.fasta_file || FastaFile.new] do |ff|
      ff.input :file, as: :file
    end
    actions
  end

  show { render "group" }

  action_item(:run_all_profiles, only: :show) do
    link_to("Run pipeline", run_all_profiles_group_path(resource), method: :post)
  end

  member_action :run_all_profiles, method: :post do
    resource.profiles.pluck(:id).each do |pid|
      resource.execute_pipeline_for_all_profiles
    end
    redirect_to request.referrer, notice: "Full stack job submitted."
  end

  batch_action "add run profile",
               form: -> { {"profile" => Profile.all.pluck(:name, :id)} } do |ids, inputs|
    ids.each do |id|
      ProfileGroupLink.create(group_id: id, profile_id: inputs["profile"])
    end
    redirect_to request.referrer, notice: "Run profile: #{Profile.find(inputs['profile']).name} has been successfully added to #{ids.count} groups"
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
