# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    
    return unless user.present?
    can :read, :all
    can :create, :all
    can :destroy, Post, author_id: user.id
    can :destroy, Comment, author_id: user.id
    return unless user.admin?
    can :destroy, Post
    can :destroy, Comment
  end
end
