class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # in case of guest
    can :manage, User, :id => user.id
  end
end
