class ProfileExecutor
  def initialize(args)
    @group = Group.find(args.fetch(:group_id))
    @profile = Profile.find(args.fetch(:profile_id))
    @errors = []
  end

  def run
    steps = [
      ->{ recreate_profile_report },
      ->{ run_alignment_tool      },
      ->{ run_filtering_tool      },
      ->{ run_tree_tool           },
      ->{ run_selection_tool      }
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
    @profile.tool_for(:alignment).execute(@report.id)
  end

  def run_filtering_tool
  end

  def run_tree_tool
    @profile.tool_for(:tree).execute(@report.id)
  end

  def run_selection_tool
    @profile.tool_for(:selection).execute(@report.id)
  end
end
