# Policy 驗證不符時使用的
class PolicyFailureException < ApplicationException
  def initialize(description)
    @status = :forbidden
    @code = :policy_validate_failure
    @message = 'this operation not suit with policies'
    @description = description
  end
end
