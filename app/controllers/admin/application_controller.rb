class Admin::ApplicationController < ActionController::Base
  include MetaTagsManageable
  include RefererRecordable
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized
  protect_from_forgery with: :exception
  before_action :check_jwt!
  before_action :authenticate_admin!
  helper_method :sidebar_menu_items

  private

  def pundit_user
    current_admin
  end

  def not_authorized
    flash[:error] = I18n.t('messages.failure.policy_validate_failure')
    redirect_to admin_root_path
  end

  def sidebar_menu_items
    @sidebar_menu_items ||= YAML.safe_load(ERB.new(File.read("#{::Rails.root}/app/controllers/admin/sidebar_menu_items.yml")).result)
  end

  def check_jwt!
    jwt = cookies[:admin_jwt]

    return unless jwt

    payload = JsonWebToken.decode(jwt)

    cookies[:admin_jwt] = current_admin.issue_jwt if payload['role'] != current_admin.role
  rescue JWT::ExpiredSignature
    cookies[:admin_jwt] = current_admin.issue_jwt if admin_signed_in?
  rescue
    sign_out(current_admin) if admin_signed_in?
    redirect_to new_admin_session_path, flash: { notice: I18n.t('messages.error.jwt_token_invalid') }
  end
end
