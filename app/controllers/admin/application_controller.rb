class Admin::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_admin!

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
end
