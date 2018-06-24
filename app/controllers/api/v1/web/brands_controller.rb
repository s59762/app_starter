class Api::V1::Web::BrandsController < Api::V1::Web::BaseController
  def index

  end

  def show

  end

  def create

  end

  def update

  end

  private

  def brand_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
