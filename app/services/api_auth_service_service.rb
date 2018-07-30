# 用於在 API 中驗證 JWT，並回傳當前使用者的身份
class ApiAuthServiceService
  include ActionController::Cookies
  attr_reader :request, :auth_header, :payload

  TIME_CHECK_LEEWAY = 10.minutes

  # 使用 JWT 來驗證
  # @param [String] request Rails 的 request 物件。由於可能需要操作 cookies 因此必須帶入完整的 request 內容。
  def initialize(request, ref: :web)
    @request = request
    @auth_header = (ref == :web) ? auth_header_from_cookies : request.headers['Authorization']

    raise AuthenticateFailureException, 'You have to provide valid JWT in HTTP header `Authorization` with `Bearer` strategy.' unless valid?

    @payload = jwt_payload
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
    @current_api_user ||= case payload['type']
                          when 'Guest'
                            Null::User.new(:user)
                          else
                            payload['type'].constantize.find(payload['sub'])
                          end
  end

  def auth_header_from_cookies
    "Bearer #{cookies["#{request.headers['Application-Scope']}_jwt"]}"
  end
end
