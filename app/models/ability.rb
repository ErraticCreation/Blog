class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
        can :read, :all
        can :create, Comment, :user_id => user.id
        can :manage, Post, :user_id => user.id
        cannot [:destroy], [Post, Comment]
      end
  end
end
