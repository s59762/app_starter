class Devise::Admins::SessionsController < Devise::SessionsController
  layout 'admin/login'
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # 登入
  # 產生 JWT 並放在 cookie
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?

    cookies[:admin_jwt] = resource.issue_jwt

    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # 登出
  # 移除 JWT
  def destroy
    cookies.delete :admin_jwt

    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
