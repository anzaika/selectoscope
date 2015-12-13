class CodemlForGroupJob < ActiveJob::Base
  queue_as :many

  def perform(group_id)
    if Group.find(group_id).tree
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
    else
      retry_job wait: 1.minutes
    end
  end
end
