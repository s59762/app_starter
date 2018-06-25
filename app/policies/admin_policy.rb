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
    return user.super? || user.owner? if admin?

    false
  end

  def create?
    return user.super? || user.owner? if admin?

    false
  end

  def update?
    return user.super? || user.owner? if admin?

    false
  end

  def suspend?
    return user.super? || user.owner? if admin?

    false
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
