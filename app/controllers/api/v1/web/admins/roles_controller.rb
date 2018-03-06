class Api::V1::Web::Admins::RolesController < Api::V1::Web::BaseController
  def show
    @roles = Admin.roles.keys

    render json: { data: @roles }
  end
end
