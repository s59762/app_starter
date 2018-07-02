class Api::V1::Web::Products::Variants::SetAsMasterController < Api::V1::Web::BaseController
  def update
    @variant = Product::Variant.find(params[:product_variant_id])
    @product = @variant.product

    raise ParametersFailureException, 'current master is equal to your choice.' if @product.master == @variant

    ActiveRecord::Base.transaction do
      disable_current_master_setting
      @variant.update is_master: true
    end

    render json: @product.variants
  end

  private

  def disable_current_master_setting
    @product.master.update is_master: false
  end
end
