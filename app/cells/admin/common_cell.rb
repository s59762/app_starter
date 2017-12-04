require_dependency 'admin/application_cell'

# Admin 介面中的基本元件
class Admin::CommonCell < Admin::ApplicationCell
  # Navi bar
  def header
    render
  end

  # 左側選單
  def sidebar
    render
  end

  # 每頁的頁面標題，包含麵包屑
  def content_header
    render
  end

  private

  # 顯示目前使用者的名稱
  def user_name(user = nil)
    user = user || Null::User.new
    user.try(:name) || "#{t('.administrator')} (#{user.email})"
  end

  # 顯示目前使用者的權限等級
  def user_level(user = nil)
    '一般'
  end

  # 顯示目前使用者的頭像
  def user_avatar(user = nil, options = {})
    class_name = options.fetch(:class, 'user-image')
    user = user || Null::User.new

    image_tag user.avatar.url, class: class_name
  end

  # 檢測 sidebar 選單是否 active。
  # 使用 path 來檢查。
  # @param [String] controller_path 這個選項所代表的 Path name
  def sidebar_menu_active?(controller_path)
    'active' if controller.controller_path.include?(controller_path)
  end

  # 檢測 sidebar 子選單是否 active。
  # 使用 path 來檢查。
  # @param [String] action name 這個子選項所代表的 action name
  def submenu_active?(action_name)
    'active' if controller.controller_name == action_name || controller.action_name == action_name
  end

  # 回傳麵包屑中「第一層」的連結 link
  def current_parent_node_link
    link_to render_content_header(options[:parent_model]), options[:parent_path]
  end

  # 回傳麵包屑中「第一層」的連結標題，通常為 `管理○○`
  def render_content_header(given_model = nil)
    target_model = given_model || options[:parent_model]
    t('actions.management', model: target_model.model_name.human)
  end
end
