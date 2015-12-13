class AlignmentForGroupJob
  include Sidekiq::Worker
  sidekiq_options queue: :one, retry: 2, timeout: 10.minutes

  def perform(group_id)
    group = Group.find(group_id)
    spec = Wrap::Pagan::Spec.new(fasta: group.to_fasta)
    return nil unless spec && (alignment = Wrap::Pagan::Run.new(spec).run)

    # run       = Run.create(report.for_run)
    # alignment = Alignment.create(fasta: fasta, meta: 'original')
    # alignment.run = run
    group.alignments << alignment
  end
end
