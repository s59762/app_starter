# Null Object for User
#
# 用來替代 nil 的 User null object
class Null::User
  # Name
  def name
    '未登入使用者'
  end

  # Email
  def email
    'test@test.com'
  end

  # 會產生 Null::Image instance 替代使用者圖像
  def avatar
    Null::Image.new
  end
end
