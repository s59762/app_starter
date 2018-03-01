# API 中 query string params 有誤時使用的 Exception
class ParametersFailureException < ApplicationException
  def initialize(description)
    @code = :parameters_failure
    @message = 'something wrong cause by parameters'
    @description = description
  end
end
