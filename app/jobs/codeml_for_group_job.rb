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
    output = Wrap::Codeml::Run.new(spec).run
    if output
      result = CodemlResult.create(output.report.to_h)
      # result && output.files.each { |f| result.files << f }
      group.codeml_result.destroy if group.codeml_result
      group.codeml_result = result
    end
  end
end
