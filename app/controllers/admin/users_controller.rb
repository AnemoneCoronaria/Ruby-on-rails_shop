class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(20)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "회원 정보가 수정되었습니다."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "회원이 삭제되었습니다."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :role, :store_name)
  end
end