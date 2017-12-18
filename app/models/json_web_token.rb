# JWT 的 Wrapper
class JsonWebToken

  # 產生 JWT
  #
  # @param [Hash] payload JWT 要包含的內容
  # @example 把使用者 ID 包裝成 JWT
  #   payload = {
  #     sub: user.id,
  #     iat: Time.current.to_i
  #   }
  #   JsonWebToken.encode(payload)
  # @return [String]
  def self.encode(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  # 解開 JWT
  #
  # @param [String] token JWT 本身
  # @return [Hash]
  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base).first
  end
end
