# API 中 JWT 經驗證發現過期時使用的 Exception
class JwtExpiredException < ApplicationException
  def initialize(description)
    @status = :unauthorized
    @code = :token_expired
    @message = 'jwt expired'
    @description = description
  end
end
