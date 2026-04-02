class Admin::ProductsController < Admin::BaseController
  def index
    @products = Product.order(created_at: :desc).page(params[:page]).per(20)
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, notice: "상품이 삭제되었습니다."
  end
end