class Seller::RegistrationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
  end

  def create
    @user = current_user
    if @user.update(seller_params)
      @user.seller!
      redirect_to root_path, notice: "판매자 등록이 완료되었습니다! 이제 상품을 등록할 수 있습니다."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def seller_params
    params.require(:user).permit(:store_name)
  end
end