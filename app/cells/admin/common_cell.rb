require_dependency 'admin/application_cell'

# Admin 介面中的基本元件
class Admin::CommonCell < Admin::ApplicationCell
  # 畫面頂部的橫條 Header，包含使用者個人選項 dropdown
  def header
    render
  end

  # 左側選單結構
  def sidebar
    render
  end

  # 每頁的頁面標題，包含麵包屑
  #
  # 用於每個獨立頁面 View 的起始位置，作為設定頁面標題之用。
  #
  # @option options [Array] :breadcrumb_units 麵包屑 units 的 Array，若沒有提供， render 出來的結果會只有 admin_root_path 的連結。
  # @option options [String] :title 指定頁面主標題
  # @option options [String] :sub_title 指定頁面副標題
  #
  # @example `admin/members#show` 的頁面標題
  #   = cell('admin/common', nil, breadcrumb_units: [{ name: '管理會員', path: admin_members_path },
  #                                                  { name: '詳細資料' }]).call(:content_header)
  #
  # @example `admin/something#really_weird` 的特殊頁面標題，自行指定標題內容
  #   = cell('admin/common', nil, title: '全站功能設定',
  #                               sub_title: '未知功能設定'
  #                               breadcrumb_units: [{ name: '進階設定', path: admin_site_config_path },
  #                                                  { name: '未知功能設定' }]).call(:content_header)
  #
  def content_header
    render
  end

  # 麵包屑
  #
  # 理論上僅提供 #content_header 使用
  # @see #content_header
  #
  def breadcrumb
    render
  end

  private

  # 回傳目前使用者的名稱
  #
  # @param user [Object] Admin 的 instance，沒有給會用 Null::User 代替
  # @return [String]
  def user_name(user = nil)
    user ||= Null::User.new
    user.try(:name) || "#{t('.administrator')} (#{user.email})"
  end

  # 顯示目前使用者的權限等級
  #
  # TODO: 尚未實作
  #
  # @param _user [Object] Admin 的 instance
  # @return [String]
  def user_level(_user = nil)
    '一般'
  end

  # 顯示目前使用者的頭像
  #
  # @param user [Object] Admin 的 instance，沒有給會用 Null::User 代替
  # @option options [String] :class 需要自行指定 image_tag 的 class 內容時可使用
  # @return [String] HTML
  def user_avatar(user = nil, options = {})
    class_name = options.fetch(:class, 'user-image')
    user ||= Null::User.new

    image_tag user.avatar.url, class: class_name
  end

  # 檢測 sidebar 選單是否 active。
  #
  # @param [String] controller_path 選單選項所代表的 path
  # @return [String] 'active' or nothing
  def sidebar_menu_active?(controller_path)
    'active' if controller.controller_path.include?(controller_path)
  end

  # 檢測 sidebar 子選單是否 active。
  #
  # @param [String] action_name 選單子選項所代表的 action name
  # @return [String] 'active' or nothing
  def submenu_active?(action_name)
    'active' if [controller.controller_name, controller.action_name].include? action_name
  end

  # 回傳麵包屑中「第一層」的連結 link
  def current_parent_node_link
    link_to render_content_header(options[:parent_model]), options[:parent_path]
  end

  # 回傳頁面主標題
  #
  # @param given_title [String] 直接指定主標題內容，預設為 nil
  #
  # @example 直接指定標題內容
  #   render_content_header('神秘頁面') # => 會直接回傳指定的字串
  # @example 不指定標題內容
  #   render_content_header # => 會回傳 locales 中指定的內容
  #
  #   # 可在 `config/locales/cells/admin/common/` 設定頁面翻譯內容
  #   # 例如 Admin::MembersController 可以用下面的方式指定頁面名稱為 '會員管理'
  #   # zh-TW:
  #   #   admin:
  #   #     common:
  #   #       page_titles:
  #   #         'members':
  #   #           main_title: 會員管理
  #
  # @return [String] 頁面主標題
  def page_title(given_title = nil)
    given_title || t(".page_titles.#{controller.controller_name}.main_title")
  end

  # 回傳頁面副標題
  #
  # @param given_title [String] 直接指定副標題內容，預設為 nil
  #
  # @example 直接指定副標題內容
  #   render_content_header('神秘頁面') # => 會直接回傳指定的字串
  # @example 不指定副標題內容
  #   render_content_header # => 會回傳 locales 中指定的內容
  #
  #   # 可在 `config/locales/cells/admin/common/` 設定頁面翻譯內容
  #   # 例如 Admin::MembersController#index 可以用下面的方式指定副標題為 '列表'
  #   # zh-TW:
  #   #   admin:
  #   #     common:
  #   #       page_titles:
  #   #         'members':
  #   #           index: 列表
  #
  # @return [String] 頁面副標題
  def page_sub_title(given_title = nil)
    given_title || t(".page_titles.#{controller.controller_name}.#{controller.action_name}")
  end

  # Render 麵包屑元件
  #
  # @param unit [Hash] 麵包屑元件的「標題」與「聯結路徑」
  # @return [String] HTML
  def render_breadcrumb_unit(unit)
    @breadcrumb_unit = unit

    if @breadcrumb_unit[:path].present?
      render :breadcrumb_unit
    else
      render :breadcrumb_last_unit
    end
  end
end
