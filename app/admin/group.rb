ActiveAdmin.register Group do
  permit_params :id,
                :pattern,
                :tree_id,
                :fasta,
                :user_id,
                fasta_file_attributes: [:file]

  scope :all
  scope :with_positive
  scope :without_positive

  index download_links: false do
    selectable_column
    column "tree" do |group|
      if group.tree
        render(partial: "groups/tnt_tree",
               locals:  {tree:    group.tree.newick,
                         width:   "400",
                         compact: true})
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

    column :alignment do |g|
      if !g.alignments.empty?
        status_tag "yes"
      else
        status_tag "no"
      end
    end
    # column "W0", sortable: "codeml_result.w0" do |g|
    #   (cod = g.codeml_result) && cod.w0 || "---"
    # end
    # column "W1" do |g|
    #   (cod = g.codeml_result) && cod.w1 || "---"
    # end
    # column "K" do |g|
    #   (cod = g.codeml_result) && cod.k || "---"
    # end
    # column "P0" do |g|
    #   (cod = g.codeml_result) && cod.p0 || "---"
    # end
    # column "P1" do |g|
    #   (cod = g.codeml_result) && cod.p1 || "---"
    # end
    actions
  end

  filter :batch, collection: -> { Batch.all }
  filter :has_paralogs
  filter :codeml_result_w0, as: :numeric, label: "codeml W0"
  filter :codeml_result_p1, as: :numeric, label: "codeml P1"
  filter :fast_result_has_positive, as: :select, values: ["true", "false"]

  form html: {multipart: true} do |f|
    f.semantic_errors
    f.inputs "Fasta", for: [:fasta_file_attributes, f.object.fasta_file || FastaFile.new] do |ff|
      ff.input :file, as: :file
    end
    actions
  end

  show do
    render "group"
  end

  member_action :run_full_stack, method: :get do
  end

  member_action :download_tree, method: :get do
    resource.download_tree
  end

  batch_action "run full-stack for" do |ids|
    ids.each {|id| RunFullStackJob.perform_async(id) }
    redirect_to request.referrer, notice: "Full stack job submitted."
  end

  controller do
    def show
      @group = Group::ForShow.find(params[:id])
    end

    def download_tree
      g = Group.find(params[:id])
      newick = g.tree.newick
      filename = "#{g.id}_tree.nwk"

      Tempfile.create(filename) do |_f|
        send_data(newick, type: "application/text", filename: filename)
      end
    end

    def create
      @group = Group.new(permitted_params['group'])
      @group.user_id = current_user.id
      if @group.save
        redirect_to @group
      else
        flash[:errors] = @group.errors.messages
        render('new')
      end
    end

  end
end
