module Null
  class User
    def name
      '未登入'
    end

    def email
      'test@test.com'
    end

    def avatar
      Null::Image.new
    end
  end
end
