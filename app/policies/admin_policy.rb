class AdminPolicy < ApplicationPolicy
  def index?
    return user.super? || user.owner? if admin?

    false
  end

  def show?
    return user.super? || user.owner? || record == user if admin?

    false
  end

  def roles?
    index?
  end

  def create?
    index?
  end

  def update?
    index?
  end

  def suspend?
    index?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
