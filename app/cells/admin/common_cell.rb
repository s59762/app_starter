require_dependency 'admin/application_cell'

# Admin 介面中的基本元件
class Admin::CommonCell < Admin::ApplicationCell
  # 每頁的頁面標題
  #
  # 用於每個獨立頁面 View 的起始位置，作為設定頁面標題之用。
  #
  # @option options [String] :title 指定頁面主標題
  # @option options [String] :sub_title 指定頁面副標題
  #
  # @example `admin/members#show` 的頁面標題
  #   = cell('admin/common').call(:content_header)
  #
  # @example `admin/something#really_weird` 的特殊頁面標題，自行指定標題內容
  #   = cell('admin/common', nil, title: '全站功能設定',
  #                               sub_title: '未知功能設定').call(:content_header)
  #
  def content_header
    render
  end

  private

  # 回傳頁面主標題
  #
  # @param given_title [String] 直接指定主標題內容，預設為 nil
  #
  # @example 直接指定標題內容
  #   page_title('神秘頁面') # => 會直接回傳指定的字串
  # @example 不指定標題內容
  #   page_title # => 會回傳 locales 中指定的內容
  #
  #   # 可在 `config/locales/page_titles` 設定頁面翻譯內容
  #   # 例如 Admin::MembersController 可以用下面的方式指定頁面名稱為 '會員管理'
  #   # zh-TW:
  #   #   page_titles:
  #   #     admin:
  #   #       members:
  #   #         main_title: 會員管理
  #
  # @return [String] 頁面主標題
  def page_title(given_title = nil)
    given_title || t("page_titles.admin.#{controller.controller_name}.main_title")
  end

  # 回傳頁面副標題
  #
  # @param given_title [String] 直接指定副標題內容，預設為 nil
  #
  # @example 直接指定副標題內容
  #   page_sub_title('神秘頁面') # => 會直接回傳指定的字串
  # @example 不指定副標題內容
  #   page_sub_title # => 會回傳 locales 中指定的內容
  #
  #   # 可在 `config/locales/page_titles` 設定頁面翻譯內容
  #   # 例如 Admin::MembersController#index 可以用下面的方式指定副標題為 '列表'
  #   # zh-TW:
  #   #   page_titles:
  #   #     admin:
  #   #       members:
  #   #         index: 列表
  #
  # @return [String] 頁面副標題
  def page_sub_title(given_title = nil)
    given_title || t("page_titles.admin.#{controller.controller_name}.#{controller.action_name}")
  end
end
