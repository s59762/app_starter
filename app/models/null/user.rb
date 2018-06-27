# Null Object for User
#
# 用來替代 nil 的 User null object
class Null::User
  attr_reader :user_model

  def initialize(user_type = :admin)
    @user_model = user_type.to_s.classify.constantize

    generate_role_methods if user_model.respond_to? :roles
  end

  # Name
  def name
    '未登入'
  end

  # Email
  def email
    'test@test.com'
  end

  # 會產生 Null::Image instance 替代使用者圖像
  def avatar
    Null::Image.new
  end

  # 在 role 欄位標示使用者未登入
  def role
    'not_signed_in'
  end

  def guest?
    true
  end

  def issue_jwt
    JsonWebToken.encode(sub: nil,
                        iat: Time.current.to_i,
                        type: 'Guest',
                        ref: 'web')
  end

  private

  def generate_role_methods
    user_model.roles.keys.each do |role|
      define_singleton_method("#{role}?") do
        false
      end
    end
  end
end
