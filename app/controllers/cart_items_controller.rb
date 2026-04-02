class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity = (cart_item.quantity || 0) + params[:quantity].to_i
    cart_item.save
    redirect_to cart_path, notice: "#{product.name}이(가) 장바구니에 담겼습니다."
  end

  def update
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.update(quantity: params[:quantity])
    redirect_to cart_path
  end

  def destroy
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path, notice: "상품이 장바구니에서 삭제되었습니다."
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end
