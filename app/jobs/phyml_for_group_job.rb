class PhymlForGroupJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :many,
                  retry: false,
                  timeout: 30.minutes,
                  backtrace: true

  def perform(group_id)
    group = Group.find(group_id).decorate
    alignment = group.gblocks_align.molphy
    spec = Wrap::Phyml::Spec.new(phylip: alignment)
    tree = Wrap::Phyml::Run.new(spec).run
    if tree
      t = Tree.create(newick: tree)
      group.tree.destroy if group.tree
      group.tree = t
    end
  end

end
