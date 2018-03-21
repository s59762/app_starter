class AdminPolicy < ApplicationPolicy
  def index?
    user.super? || user.owner?
  end

  def roles?
    user.super? || user.owner?
  end

  def create?
    user.super? || user.owner?
  end

  def update?
    user.super? || user.owner?
  end

  def suspend?
    user.super? || user.owner?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
