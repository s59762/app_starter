class ApplicationForm < Reform::Form
  include Reform::Form::ActiveModel
  include Reform::Form::ActiveModel::FormBuilderMethods
  include Reform::Form::ActiveModel::Validations

  def client_side_validation_hash(force = nil)
    model.client_side_validation_hash(force)
  end

  def self.human_attribute_name(attribute_key_name, options = {})
    I18n.t("activerecord.attributes.#{self.model_name.to_s.underscore}.#{attribute_key_name}", options)
  end
end
