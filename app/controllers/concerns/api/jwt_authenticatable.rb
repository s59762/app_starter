# 提供 WebApi 透過 JWT 來驗證使用者身份的功能

module Api
  module JwtAuthenticatable
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_for_jwt!
    end

    private

    # 驗證 JWT 的正確性
    #
    # @raise [AuthenticateFailureException] 若 request header 沒有提供 JWT 會 raise 例外
    def authenticate_for_jwt!
      @api_auth ||= ApiAuthServiceService.new(request.headers['Authorization'])
    end

    # 取得當前的 API user
    #
    # @return [Object] 會回傳 user model 的 instance
    def current_api_user
      @current_api_user ||= @api_auth.call
    end

    # 驗證當前使用者身份
    #
    # @param [String] role 欲驗證的身份 type
    #
    # @example 驗證是否為 Admin
    # signed_in_as?('Admin')
    #
    # @return [Boolean]
    def signed_in_as?(role)
      jwt_payload[:type] == role
    end

    # 驗證當前使用者身份是否為 'Admin'
    def admin_signed_in?
      current_api_user.class.name == 'Admin'
    end

    # 取得 JWT Payload
    #
    # @return [Hash] payload 內容
    def jwt_payload
      @api_auth.payload
    end
  end
end