# Policy 驗證不符時使用的
class PolicyFaliureException < ApplicationException
  def initialize(description)
    @status = :forbidden
    @code = :policy_validate_failure
    @message = 'jwt authentication failed'
    @description = description
  end
end
