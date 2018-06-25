class BrandPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    return user.super? || user.owner? || user.stock_manager? if admin?

    false
  end

  def update?
    create?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
