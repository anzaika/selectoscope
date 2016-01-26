class CodemlForGroupJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 60.minutes,
                  backtrace: true

  def perform(group_id)
    group = Group.find(group_id).decorate
    alignment = group.gblocks_align
    tree = group.simple_tree(short: false)
    spec = Wrap::Codeml::Spec.new(molphy: alignment.molphy, tree: tree)
    report = Wrap::Codeml::Run.new(spec).run
    if report
      result = CodemlResult.create(report.to_h)
      group.codeml_result.destroy if group.codeml_result
      group.codeml_result = result
    end
  end
end
