# 將例外發生時回傳的訊息標準化，可以統一在 ApplicationController rescue，協助客戶端理解錯誤狀況
class ApplicationException < StandardError
  def response
    { code: @code, message: @message, description: @description, validation_errors: {} }
  end

  def status
    @status || :unprocessable_entity
  end
end
