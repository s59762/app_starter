class User::CollectionPolicy < ApplicationPolicy
  def index?
    return false if admin?

    true
  end

  def show?
    return false if admin?

    record.user_id == user.id
  end

  def create?
    index?
  end

  def destroy?
    show?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
