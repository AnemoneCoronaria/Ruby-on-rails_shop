class WishlistItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:product_id])
    current_user.wishlist.products << product unless current_user.wishlist.products.include?(product)
    redirect_back fallback_location: product_path(product), notice: "찜 목록에 추가했습니다."
  end

  def destroy
    product = Product.find(params[:product_id])
    current_user.wishlist.products.delete(product)
    redirect_back fallback_location: products_path, notice: "찜 목록에서 삭제했습니다."
  end
end
