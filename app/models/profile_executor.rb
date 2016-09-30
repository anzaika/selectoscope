class ProfileExecutor

  attr_reader :group, :profile, :report

  def initialize(args)
    @group = Group.find(args.fetch(:group_id))
    @profile = Profile.find(args.fetch(:profile_id))
    @errors = []
  end

  # TODO: do not start if group pre-processing is not over
  def run
    steps = [
      ->{ recreate_profile_report },
      ->{ run_alignment_tool      }
      # ->{ run_tree_tool           },
      # ->{ run_selection_tool      }
    ]

    steps.each { |step| break unless step.call }
    true
  end

  private

  def proceed; true; end

  def stop(message="")
    @errors << message if message.present?
    false
  end

  def recreate_profile_report
    report = ProfileReport.where({group_id: @group.id, profile_id: @profile_id}).first
    report.destroy if report
    @report = ProfileReport.create(profile_id: @profile.id, group_id: @group.id)
    @report ? proceed : stop("Couldn't create a new ProfilReport")
  end

  def run_alignment_tool
    if @profile.tool_for(:alignment)
      alignment = AlignmentToolExecutor.new({profile_executor: self}).execute
      stop("no alignment") unless alignment
    else
      fasta_file = FastaFile.create(file: File.open(@group.fasta_file.file.path), )
      alignment = Alignment.create(fasta_file: fasta_file)
    end
    @report.alignment = alignment
    @report.save
  end

  def run_filtering_tool
  end

  def run_tree_tool
    if @profile.tool_for(:tree)
      tree = TreeToolExecutor.new({profile_executor: self}).execute
      stop("no tree") unless tree
    else
      fasta_file = FastaFile.create(file: File.open(@group.fasta_file.file.path), )
      alignment = Alignment.create(fasta_file: fasta_file)
    end
    @report.alignment = alignment
    @report.save
  end

  def run_selection_tool
    @profile.tool_for(:selection).execute(@report.id)
  end
end
