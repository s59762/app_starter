class User::ShippingInfoPolicy < ApplicationPolicy
  def index?
    return false if admin?

    record == user
  end

  def create?
    index?
  end

  def update?
    return false if admin?

    record.user_id == user.id
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
