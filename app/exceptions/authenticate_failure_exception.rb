# API 中 JWT 驗證時發生錯誤的 Exception
class AuthenticateFailureException < ApplicationException
  def initialize(description)
    @code = :token_authenticate_failure
    @message = 'jwt authentication failed'
    @description = description
  end
end
