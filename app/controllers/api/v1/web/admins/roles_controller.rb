class Api::V1::Web::Admins::RolesController < Api::V1::Web::BaseController
  def show
    check_policy AdminPolicy.new(current_api_user, :admin).roles?

    roles = Admin.roles.keys

    render json: { data: roles }
  end
end
