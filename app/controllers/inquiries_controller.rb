class InquiriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_inquiry, only: [:show, :edit, :update, :destroy]

  def index
    @inquiries = Inquiry.by_status(params[:status]).search(params[:q]).latest
    
    # 비공개 문의 필터링
    unless user_signed_in?
      @inquiries = @inquiries.where(is_private: false)
    else
      unless current_user.admin? || current_user.seller?
        # 일반 사용자는 자신의 비공개 문의만 볼 수 있음
        @inquiries = @inquiries.where("is_private = false OR user_id = ?", current_user.id)
      end
    end
    
    @inquiries = @inquiries.page(params[:page]).per(15)
  end

  def my_inquiries
    @inquiries = current_user.inquiries.latest.page(params[:page]).per(15)
    @my_inquiries = true
    render :index
  end

  def show
    # 비공개 문의 체크
    if @inquiry.is_private && (!user_signed_in? || (@inquiry.user != current_user && !current_user.admin? && !current_user.seller?))
      redirect_to inquiries_path, alert: "비공개 문의입니다. 작성자와 관리자/판매자만 볼 수 있습니다."
      return
    end
  end

  def new
    @inquiry = current_user.inquiries.build
  end

  def create
    @inquiry = current_user.inquiries.build(inquiry_params)
    if @inquiry.save
      redirect_to @inquiry, notice: "문의가 등록되었습니다."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to inquiries_path unless current_user == @inquiry.user
  end

  def update
    if @inquiry.update(inquiry_params)
      redirect_to @inquiry, notice: "문의가 수정되었습니다."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @inquiry.destroy
    redirect_to inquiries_path, notice: "문의가 삭제되었습니다."
  end

  private

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end

  def inquiry_params
    params.require(:inquiry).permit(:title, :content, :category, :product_id, :is_private)
  end
end