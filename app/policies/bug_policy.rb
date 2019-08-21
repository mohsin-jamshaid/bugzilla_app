class BugPolicy < ApplicationPolicy
  def index?
    (user.qa? || user.developer?) && user.projects.exists?(record&.id)
  end

  def create?
    user.qa? && user.projects.exists?(record&.project_id)
  end

  def update?
    user.qa? && record.creator_id == user.id
  end

  def destroy?
    user.qa? && record.creator_id == user.id
  end

  def assign_bug?
    user.developer? && user.projects.exists?(record.project_id)
  end

  def resolve_bug?
    user.developer? && user.projects.exists?(record.project_id)
  end
end
