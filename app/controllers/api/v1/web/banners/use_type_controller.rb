class Api::V1::Web::Banners::UseTypeController < Api::V1::Web::BaseController
  def show
    types = Banner.use_types.keys

    render json: { data: types }
  end
end
