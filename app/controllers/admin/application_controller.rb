class Admin::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_admin!
  helper_method :sidebar_menu_items

  private

  # 紀錄 referer
  def write_original_referer
    session[:original_referer] = request.referer
  end

  # 清除 referer
  def clear_original_referer
    session.delete(:original_referer)
  end

  # 讀取 referer
  def original_referer
    session[:original_referer]
  end

  def sidebar_menu_items
    @sidebar_menu_items ||= YAML.safe_load(ERB.new(File.read("#{::Rails.root}/app/controllers/admin/sidebar_menu_items.yml")).result)
  end
end
