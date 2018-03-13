class Admin::ApplicationController < ActionController::Base
  include RefererRecordable
  include JwtCheckable

  protect_from_forgery with: :exception
  before_action :authenticate_admin!
  before_action :check_jwt!
  helper_method :sidebar_menu_items

  private

  def sidebar_menu_items
    @sidebar_menu_items ||= YAML.safe_load(ERB.new(File.read("#{::Rails.root}/app/controllers/admin/sidebar_menu_items.yml")).result)
  end

  def check_jwt!
    jwt = cookies[:admin_jwt]

    return unless jwt

    JsonWebToken.decode(jwt)
  rescue
    sign_out(current_user)
  end
end
