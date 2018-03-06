class Api::V1::Web::AdminsController < Api::V1::Web::BaseController
  def index
    @admins = query_with_paginate_and_sort_options_for(Admin)

    render json: @admins,
           meta: pagination_dict(@admins).merge({
            lastest_update_at: @admins.order(updated_at: :asc).last.updated_at.to_i
           })
  end

  def show
    @admin = Admin.find(params[:id])

    render json: @admin
  end

  def create
    form = Admin::AdminForm.new(Admin.new)

    return raise ValidationFailureException, form unless form.validate(admin_params)

    form.save

    render json: form.model
  end

  private

  def admin_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
