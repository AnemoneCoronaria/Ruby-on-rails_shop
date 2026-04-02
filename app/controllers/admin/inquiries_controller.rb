class Admin::InquiriesController < Admin::BaseController
  def index
    @inquiries = Inquiry.order(created_at: :desc).page(params[:page]).per(20)
  end

  def show
    @inquiry = Inquiry.find(params[:id])
  end

  def destroy
    @inquiry = Inquiry.find(params[:id])
    @inquiry.destroy
    redirect_to admin_inquiries_path, notice: "문의가 삭제되었습니다."
  end

  
end