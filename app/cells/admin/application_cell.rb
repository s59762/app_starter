class Admin::ApplicationCell < Cell::ViewModel
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TranslationHelper
  include ActionView::RecordIdentifier
  include Cell::Translation
  include Devise::Controllers::Helpers

  private

  def render_action_name
    t("actions.#{options[:action]}", model: options[:model].model_name.human)
  end

  def tag_builder
    super.tap { |builder| builder.class_eval { include Cell::Slim::Rails } }
  end
end
