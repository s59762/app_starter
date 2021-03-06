class UserPolicy < ApplicationPolicy
  def index?
    return user.super? || user.owner? || user.accounter? if admin?

    false
  end

  def show?
    return user.super? || user.owner? || user.accounter? if admin?

    record == user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
