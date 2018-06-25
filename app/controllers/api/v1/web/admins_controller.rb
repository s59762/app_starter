class Api::V1::Web::AdminsController < Api::V1::Web::BaseController
  before_action :for_admin_only!, except: %i(show)

  def index
    check_policy AdminPolicy.new(current_api_user, :admin).index?

    admins = FetchingDataService.call(Admin, params)
    result = Api::DataCacheService.call(admins, request)

    render json: result
  end

  def show
    admin = Admin.find(params[:id])

    check_policy AdminPolicy.new(current_api_user, :admin).show?

    render json: admin
  end

  def create
    admin = Admin.new
    form = Admin::NewAdminForm.new(admin)

    check_policy AdminPolicy.new(current_api_user, admin).create?

    return raise ValidationFailureException, form unless form.validate(admin_params)

    form.save

    render json: form.model
  end

  def update
    admin = Admin.find(params[:id])
    form = Admin::EditAdminForm.new(admin)

    check_policy AdminPolicy.new(current_api_user, admin).update?

    return raise ValidationFailureException, form unless form.validate(admin_params)

    form.save

    render json: form.model
  end

  private

  def admin_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
