class Api::V1::Web::Products::ImagesController < Api::V1::Web::BaseController
  def create
    check_policy ProductPolicy.new(current_api_user, :product).create?

    image = Product::Image.new(product_id: params[:product_id])
    @form = Admin::ProductImageForm.new(image)

    return raise ValidationFailureException, @form unless @form.validate(image_params)

    @form.save

    render_result
  end

  def destroy
    product = Product.find(params[:product_id])

    check_policy ProductPolicy.new(current_api_user, product).update?

    image = product.normal_images.find(params[:id])

    image.destroy

    render json: product,
           include: [:normal_images, :variants_with_master, 'option_types.option_values'],
           show_variants: true,
           show_options: true,
           show_normal_images: true
  end

  private

  def image_params
    params.require(:product).permit(:use_case, images: [])
  end

  # 因為這個 action 同時負責 `/products/images` 和 `/products/:product_id/images` 兩個 routes 的 POST request
  # 所以根據 params[:product_id] 是否存在，分別 render 不同的 json 結果。
  # 第一種狀況是上傳 product description editor 中的圖片，因此只需回傳 image 本身即可。
  # 第二種狀況是上傳 product normal image，因此需要回傳 product 的完整資訊來更新前端畫面。
  def render_result
    if @form.product_id.nil?
      render json: Product::Image.where(id: @form.created_image_ids)
    else
      render json: Product.find(@form.product_id),
             include: [:normal_images, :variants_with_master, 'option_types.option_values'],
             show_variants: true,
             show_options: true,
             show_normal_images: true
    end
  end
end
