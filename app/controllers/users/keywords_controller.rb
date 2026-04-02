module Users
  class KeywordsController < ApplicationController
    before_action :authenticate_user!

    def edit
      @keywords = Keyword.grouped
    end

    def update
      selected_ids = params[:keyword_ids] || []
      selected_keywords = Keyword.where(id: selected_ids)
      current_user.keywords = selected_keywords
      redirect_to root_path, notice: "키워드가 저장되었습니다! 맞춤 상품을 추천해드릴게요."
    end
  end
end