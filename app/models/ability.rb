class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.user?
      can %i(read update), User, id: user.id

      can :create, [Batch, Group, RunProfileToolLink]
      can :manage, [Batch, Group, RunProfile], user_id: user.id

      can :read, [Alignment, CodemlResult, FastResult, Tree, RunReport, Tool], group: {user_id: user.id}
    end
  end
end
