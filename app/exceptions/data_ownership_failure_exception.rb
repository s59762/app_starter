# API 中 query string params 有誤時使用的 Exception
class DataOwnershipFailureException < ApplicationException
  def initialize(description)
    @status = :forbidden
    @code = :data_ownership_failure
    @message = 'can not access data that own by other people.'
    @description = description
  end
end
