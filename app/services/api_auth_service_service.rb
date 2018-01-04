# 用於在 API 中驗證 JWT，並回傳當前使用者的身份
class ApiAuthServiceService
  # 使用 JWT 來驗證
  # @param [String] auth_header `request.headers['Authorization']` 的內容
  def initialize(auth_header)
    @auth_header = auth_header

    raise AuthenticateFailureException, 'You have to provide valid JWT in HTTP header `Authorization` with `Bearer` strategy.' unless valid?

    @payload = jwt_payload
  end

  def call
    resource_class = payload['type'].constantize
    current_user = resource_class.find(payload['sub'])

    current_user
  end

  private

  attr_reader :auth_header, :payload

  def valid?
    auth_header.present?
  end

  def jwt_payload
    strategy, token = auth_header.split(' ')

    raise AuthenticateFailureException, 'You have to provide valid JWT in HTTP header `Authorization` with `Bearer` strategy.' unless (strategy || '').casecmp('bearer').zero?

    JsonWebToken.decode(token)
  rescue ::JWT::ExpiredSignature
    raise AuthenticateFailureException, 'auth token was expired'
  rescue ::JWT::DecodeError,
         ::JWT::VerificationError
    raise AuthenticateFailureException, 'Invalid auth token'
  end
end
