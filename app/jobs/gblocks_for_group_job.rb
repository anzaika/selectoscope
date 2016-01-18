class GblocksForGroupJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 10.minutes,
                  backtrace: true

  def perform(group_id)
    group = Group.find(group_id).decorate
    spec = Wrap::Gblocks::Spec.new(fasta: group.orig_align.fasta)
    fasta = Wrap::Gblocks::Run.new(spec).run
    return nil unless fasta
    align = Alignment.create(fasta: fasta, meta: 'gblocks')
    group.alignments << align
  end
end
