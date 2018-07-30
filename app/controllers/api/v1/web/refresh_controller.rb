class Api::V1::Web::RefreshController < Api::V1::Web::BaseController
  skip_before_action :authenticate_for_jwt!, only: :create

  def create
    return if request.origin != "#{ENV['http_protocol']}://#{ENV['app_domain']}"

    @scope = request.headers['Application-Scope']

    send("issue_#{@scope}_jwt")

    render json: { messages: ['ok'] }
  end

  private

  def issue_admin_jwt
    return cookies[:admin_jwt] = current_admin.issue_jwt if admin_signed_in?
  end

  def issue_user_jwt
    cookies[:user_jwt] = user_signed_in? ? current_user.issue_jwt : Null::User.new.issue_jwt
  end
end
