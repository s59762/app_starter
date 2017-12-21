# server side validation 沒過時可以使用的 Exception
class ValidationFailureException < ApplicationException
  # 把 form object 傳進來
  # @param [Object] form Form Object
  def initialize(form)
    @code = :validation_failure
    @message = 'Validation of params failed'
    @description = 'Please check the validation_errors key (hash) for more details.'
    @errors = form.errors.to_h
  end

  # 把 validation 的錯誤訊息加入 response
  def response
    super.merge({ validation_errors: @errors })
  end
end
