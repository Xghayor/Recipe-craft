class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :read, Recipe
      can :create, Recipe
      can :destroy, Recipe, user_id: user.id

      can :read, Food
      can :create, Food
      can :destroy, Food, user_id: user.id
    end
  end
end
