class ProjectPolicy < ApplicationPolicy
  def create?
    user.manager?
  end

  def update?
    user.manager? && record.creator_id == user.id
  end

  def show?
    (user.manager? && record.creator_id == user.id) || !user.projects.find_by(id: record.id).nil?
  end

  def destroy?
    update?
  end

  def assign_project?
    update?
  end

  def remove_from_project?
    update?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.manager?
        scope.where(creator_id: user.id).order(:created_at)
      else
        user.projects.order(:created_at)
      end
    end
  end
end
