class FastForGroupJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 60.minutes,
                  backtrace: true

  def perform(group_id)
    group = Group.find(group_id).decorate
    return nil unless group.codeml_result

    alignment = group.gblocks_align
    codeml_result = group.codeml_result
    spec =
      Wrap::Fast::Spec
        .new(
          molphy: alignment.molphy,
          w0: codeml_result.w0,
          w2: codeml_result.w1,
          k: codeml_result.k,
          p0: codeml_result.p0,
          p1: codeml_result.p1,
          tree: codeml_result.tree
        )
    report = Wrap::Fast::Run.new(spec).run
    fast_result = FastResult.create(report.to_h)
    group.fast_result = fast_result
  end
end
