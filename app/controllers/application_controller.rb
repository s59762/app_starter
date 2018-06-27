class ApplicationController < ActionController::Base
  include MetaTagsManageable
  include ShoppingCartUseable

  before_action :issue_jwt_for_guest

  protect_from_forgery with: :exception

  def issue_jwt_for_guest
    return if cookies[:user_jwt].present?

    cookies[:user_jwt] = Null::User.new(:user).issue_jwt
  end
end
