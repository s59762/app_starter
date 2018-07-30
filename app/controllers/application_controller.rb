class ApplicationController < ActionController::Base
  include MetaTagsManageable
  include ShoppingCartUseable

  before_action :issue_jwt_for_guest
  before_action :check_jwt!

  protect_from_forgery with: :exception

  def issue_jwt_for_guest
    return if cookies[:user_jwt].present?

    cookies[:user_jwt] = Null::User.new(:user).issue_jwt
  end

  private

  def check_jwt!
    jwt = cookies[:user_jwt]
    return unless jwt
    payload = JsonWebToken.decode(jwt)

    return unless user_signed_in?

    cookies[:user_jwt] = current_user.issue_jwt if payload['sub'] != current_user.id
  rescue JWT::ExpiredSignature
    cookies[:user_jwt] = user_signed_in? ? current_user.issue_jwt : Null::User.new.issue_jwt
  rescue
    cookies.delete(:user_jwt)
    sign_out(current_user)
    redirect_to root_path, flash: { notice: I18n.t('messages.error.jwt_token_invalid') }
  end
end
