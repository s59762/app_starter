require_dependency 'admin/application_controller'

class Admin::Profile::PasswordController < Admin::ApplicationController
  def update
    @admin = current_admin

    if @admin.update_with_password(password_params)
      sign_in @admin, bypass: true
      redirect_to admin_profile_path, flash: { success: '密碼已經成功變更' }
    else
      flash[:error] = '請您再確認一次密碼是否輸入正確'
      render 'admin/profile/show'
    end
  end

  private

  def password_params
    params.require(:admin).permit(:current_password, :password, :password_confirmation)
  end
end
