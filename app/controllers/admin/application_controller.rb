class Admin::ApplicationController < ActionController::Base
  include RefererRecordable

  protect_from_forgery with: :exception
  before_action :check_jwt!
  before_action :authenticate_admin!
  helper_method :sidebar_menu_items

  private

  def sidebar_menu_items
    @sidebar_menu_items ||= YAML.safe_load(ERB.new(File.read("#{::Rails.root}/app/controllers/admin/sidebar_menu_items.yml")).result)
  end

  def check_jwt!
    jwt = cookies[:admin_jwt]

    return unless jwt

    JsonWebToken.decode(jwt)
  rescue JWT::ExpiredSignature
    cookies[:admin_jwt] = current_admin.issue_jwt if admin_signed_in?
  rescue
    sign_out(current_admin) if admin_signed_in?
    redirect_to new_admin_session_path, flash: { notice: I18n.t('messages.error.jwt_token_been_modified') }
  end
end
