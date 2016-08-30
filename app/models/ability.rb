class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.user?
      can %i(read update), User, id: user.id

      can :create, [Batch, Group, ProfileToolLink]
      can :manage, [Batch, Group, Profile], user_id: user.id

      can :read, [Alignment, CodemlResult, FastResult, Tree, RunReport, Tool], group: {user_id: user.id}
    end
  end
end
