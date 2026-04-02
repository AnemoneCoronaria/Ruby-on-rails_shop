class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @inquiry = Inquiry.find(params[:inquiry_id])
    
    # 비공개 문의는 작성자, 관리자, 판매자만 답변 가능
    if @inquiry.is_private && @inquiry.user != current_user && !current_user.admin? && !current_user.seller?
      redirect_to @inquiry, alert: "비공개 문의는 답변 권한이 없습니다."
      return
    end
    
    # 관리자나 판매자만 답변 가능
    unless current_user.admin? || current_user.seller?
      redirect_to @inquiry, alert: "답변 권한이 없습니다."
      return
    end
    
    @answer = @inquiry.answers.build(content: params[:answer][:content])
    @answer.user = current_user
    
    if @answer.save
      redirect_to @inquiry, notice: "답변이 등록되었습니다."
    else
      redirect_to @inquiry, alert: "답변 등록에 실패했습니다."
    end
  end
end