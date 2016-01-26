class AlignmentForGroupJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 60.minutes,
                  backtrace: true

  def perform(group_id)
    group = Group.find(group_id)
    spec = Wrap::Muscle::Spec.new(fasta: group.to_fasta)
    return nil unless spec && (alignment = Wrap::Muscle::Run.new(spec).run)

    # run       = Run.create(report.for_run)
    # alignment = Alignment.create(fasta: fasta, meta: 'original')
    # alignment.run = run
    group.alignments << alignment
  end
end
