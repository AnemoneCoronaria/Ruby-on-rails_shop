class HomeController < ApplicationController
  def index
    @featured_products = Product.latest.limit(4)
    @popular_products = Product.popular.limit(8)

    if user_signed_in? && current_user.keywords.any?
      user_kw_names = current_user.keywords.pluck(:name)
      @matched_products = Product.with_keywords(user_kw_names).latest.limit(8)
    else
      @matched_products = []
    end
  end
end
