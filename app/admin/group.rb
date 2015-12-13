ActiveAdmin.register Group do
  permit_params :id,
                :pattern,
                :tree_id,
                :fasta,
                :user_id,
                fasta_file_attributes: [:file]

  scope :all
  scope :with_codeml
  scope :with_fast
  scope :with_tree
  scope :with_positive
  scope :without_positive

  index download_links: false do
    selectable_column
    column "tree" do |group|
      if group.decorate.tree
        render(partial: "groups/tnt_tree",
               locals:  {tree:    group.decorate.tree_for_group_index_view,
                         width:   "400",
                         compact: true})
      end
    end
    column :sequences_count, sortable: :sequences_count do |group|
      group.sequences.count
    end

    column :avg_sequence_length do |group|
      group.avg_sequence_length.to_i
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
  filter :sequences_count
  filter :has_paralogs
  filter :codeml_result_w0, as: :numeric, label: "codeml W0"
  filter :codeml_result_p1, as: :numeric, label: "codeml P1"
  filter :fast_result_has_positive, as: :select, values: ["true", "false"]
  filter :avg_sequence_length

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

  member_action :compute_alignment, method: :get do
    resource.compute_alignment
  end

  member_action :compute_gblocks, method: :get do
    resource.compute_gblocks
  end

  member_action :compute_phyml, method: :get do
    resource.compute_phyml
  end

  member_action :compute_codeml, method: :get do
    resource.compute_codeml
  end

  member_action :compute_fast, method: :get do
    resource.compute_fast
  end

  member_action :download_tree, method: :get do
    resource.download_tree
  end

  collection_action :compute_alignments, method: :get do
    collection.compute_alignments
  end

  controller do
    def show
      @group = Group.find(params[:id]).decorate
    end

    def compute_alignment
      AlignmentForGroupJob.perform_async(params[:id])
      flash[:notice] = "Alignment Job has been sent for execution"
      redirect_to resource_path(resource.id)
    end

    def compute_gblocks
      GblocksForGroupJob.perform_later(params[:id])
      flash[:notice] = "Gblocks Job has been sent for execution"
      redirect_to resource_path(resource.id)
    end

    def compute_phyml
      PhymlForGroupJob.perform_later(params[:id])
      flash[:notice] = "Phyml Job has been sent for execution"
      redirect_to resource_path(resource.id)
    end

    def compute_codeml
      CodemlForGroupJob.perform_later(params[:id])
      flash[:notice] = "Codeml Job has been sent for execution"
      redirect_to resource_path(resource.id)
    end

    def compute_fast
      FastForGroupJob.perform_later(params[:id])
      flash[:notice] = "Fast Job has been sent for execution"
      redirect_to resource_path(resource.id)
    end

    def download_tree
      g = Group.find(params[:id])
      newick = g.tree.newick
      filename = "#{g.id}_tree.nwk"

      Tempfile.create(filename) do |_f|
        send_data(newick, type: "application/text", filename: filename)
      end
    end
  end

  batch_action "generate alignment for" do |ids|
    ids.each {|id| AlignmentForGroupJob.perform_async(id) }
    redirect_to request.referrer, notice: "Alignments submitted"
  end

  batch_action "run full-stack for" do |ids|
    ids.each {|id| AlignmentForGroupJob.perform_async(id) }
    ids.each {|id| GblocksForGroupJob.perform_later(id) }
    ids.each {|id| PhymlForGroupJob.perform_later(id) }
    ids.each {|id| CodemlForGroupJob.perform_later(id) }
    ids.each {|id| FastForGroupJob.perform_later(id) }
    redirect_to request.referrer, notice: "Full stack submitted"
  end

  controller do
    def create
      if Rails.env.development?
        puts "*" * 20
        puts params.inspect
        puts "*" * 20
      end
      super
    end
  end
end
