# Admin UI 的 cells 都繼承這個 class。
# include 所有需要用到的 modules
# @abstract
class Admin::ApplicationCell < Cell::ViewModel
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TranslationHelper
  include ActionView::RecordIdentifier
  include Cell::Translation
  include Devise::Controllers::Helpers

  private

  # 這是 cells gem issue 的 walkaround。解決 block 傳入 tag helper 時，block 中的 element 會被 escape 掉，直接輸出的問題。
  #   詳細請見：https://github.com/trailblazer/cells-slim/issues/14
  def tag_builder
    super.tap { |builder| builder.class_eval { include Cell::Slim::Rails } }
  end

  # 建立 Null::User object，使用者未登入時會使用到這個方法
  def null_user
    @null_user ||= Null::User.new
  end
end
