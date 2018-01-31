ActionMailer::Base.smtp_settings = {
  address: ENV['smtp_server'],
  port: ENV['smtp_port'],
  enable_starttls_auto: true,
  user_name: ENV['mailgun_user_name'],
  password: ENV['mailgun_password'],
  authentication: 'login'
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: 'utf-8'
