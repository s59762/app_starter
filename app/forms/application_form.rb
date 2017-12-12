# Application 的 FormObject 都繼承這個 class。include 所有需要用到的 modules 以及定義共用的 methods。
# @abstract
class ApplicationForm < Reform::Form
  include Reform::Form::ActiveModel
  include Reform::Form::ActiveModel::FormBuilderMethods
  include Reform::Form::ActiveModel::Validations

  # workaround for `client_side_validation` gem
  def client_side_validation_hash(force = nil)
    model.client_side_validation_hash(force)
  end

  # workaround for i18n issue of form labels
  def self.human_attribute_name(attribute_key_name, options = {})
    I18n.t("activerecord.attributes.#{model_name.to_s.underscore}.#{attribute_key_name}", options)
  end
end
