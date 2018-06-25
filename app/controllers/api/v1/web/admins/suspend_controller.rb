class Api::V1::Web::Admins::SuspendController < Api::V1::Web::BaseController
  def update
    admin = Admin.find(params[:admin_id])

    check_policy AdminPolicy.new(current_api_user, admin).suspend?

    admin.update is_suspended: !admin.is_suspended

    render json: admin
  end
end
