# 用於在 API 中驗證 JWT，並回傳當前使用者的身份
class ApiAuthServiceService
  attr_reader :auth_header, :payload

  TIME_CHECK_LEEWAY = 10.minutes

  # 使用 JWT 來驗證
  # @param [String] auth_header `request.headers['Authorization']` 的內容
  def initialize(auth_header)
    @auth_header = auth_header

    raise AuthenticateFailureException, 'You have to provide valid JWT in HTTP header `Authorization` with `Bearer` strategy.' unless valid?

    @payload = jwt_payload

    validate_api_user_token
  end

  # 回傳當前的 API User
  #
  # @return [Object] Admin or Client instance
  def call
    current_api_user
  end

  private

  # 檢查是否有提供 auth header
  #
  # @return [Bollean]
  def valid?
    auth_header.present?
  end

  # 解碼客戶端端提供的 JWT
  #
  # @return [Hash] jwt payload
  def jwt_payload
    strategy, token = auth_header.split(' ')

    raise AuthenticateFailureException, 'You have to provide valid JWT in HTTP header `Authorization` with `Bearer` strategy.' unless (strategy || '').casecmp('bearer').zero?

    JsonWebToken.decode(token)
  rescue ::JWT::ExpiredSignature
    raise JwtExpiredException, 'auth token was expired'
  rescue ::JWT::DecodeError,
         ::JWT::VerificationError
    raise AuthenticateFailureException, 'Invalid auth token'
  end

  # 從 JWT payload 提供的資訊找到 API user
  #
  # @return [Object] Admin or Client instance
  def current_api_user
    @current_api_user ||= payload['type'].constantize.find(payload['sub'])
  end

  # 若 JWT 是由 web 端登入所取得的，驗證 JWT 發行時間是否在使用者登入時間的正常範圍內
  # 如果 JWT 因使用者的登入行為失效則顯示錯誤訊息
  def validate_api_user_token
    return unless payload['ref'] == 'web'

    # raise AuthenticateFailureException, 'auth token was expired due to user activity.' if payload['iat'] < (current_api_user.current_sign_in_at - TIME_CHECK_LEEWAY).to_i
  end
end
