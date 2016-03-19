class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.user?
      can :create, [Batch, Group]
      can :manage, [Batch, Group], user_id: user.id

      can :read, [Alignment, CodemlResult, FastResult]

      can %i(read update), User, id: user.id
      can :read, RunReport, user_id: user.id
    end
  end
end
