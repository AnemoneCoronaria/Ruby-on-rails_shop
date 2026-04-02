class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  #layout "admin"  # 관리자용 레이아웃 (선택사항)

  private

  def require_admin!
    unless current_user.admin?
      redirect_to root_path, alert: "관리자 권한이 필요합니다."
    end
  end
end