class Api::V1::Web::AdminsController < Api::V1::Web::BaseController
  before_action :for_admin_only!, except: %i[show]

  def index
    admins = FetchingDataService.call(Admin, params)
    result = Api::DataCacheService.call(admins, request)

    render json: result
  end

  # def show
  #   @admin = Admin.find(params[:id])

  #   render json: @admin
  # end

  def create
    form = Admin::NewAdminForm.new(Admin.new)

    return raise ValidationFailureException, form unless form.validate(admin_params)

    form.save

    render json: form.model
  end

  def update
    form = Admin::EditAdminForm.new(Admin.find(params[:id]))

    return raise ValidationFailureException, form unless form.validate(admin_params)

    form.save

    render json: form.model
  end

  private

  def admin_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
