class ProjectPolicy < ApplicationPolicy
  def create?
    user.manager?
  end

  def update?
    user.manager? && record.creator_id == user.id
  end

  def show?
    user.manager? || !user.projects.find_by(id: record.id).nil?
  end

  def destroy?
    user.manager? && record.creator_id == user.id
  end

  def assign_project?
    user.manager? && record.creator_id == user.id
  end

  def remove_from_project?
    user.manager? && record.creator_id == user.id
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.manager?
        scope.where(creator_id: user.id)
      else
        user.projects
      end
    end
  end
end
