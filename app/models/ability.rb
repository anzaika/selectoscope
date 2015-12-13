class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, ActiveAdmin::Page, name: "Dashboard"
    if user.admin?
      can :manage, :all
    elsif user.user?
      can :create, Group
      can %i(read update destroy), Group, user_id: user.id
      can :create, Batch
      can %i(read update destroy), Batch, user_id: user.id
      can %i(read update), User, id: user.id
    end
  end
end
