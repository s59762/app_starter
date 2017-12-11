require_dependency 'admin/application_controller'

class Admin::ProfileController < Admin::ApplicationController
  def show
    @admin = current_admin
  end

  def update
    @admin = current_admin

    if @admin.update(profile_params)
      redirect_to admin_profile_path, flash: { success: '成功編輯檔案' }
    else
      render :show
    end
  end

  private

  def profile_params
    params.require(:admin).permit(:name, :avatar)
  end
end
