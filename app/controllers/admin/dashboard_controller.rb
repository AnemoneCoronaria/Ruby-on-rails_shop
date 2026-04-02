class Admin::DashboardController < Admin::BaseController
  def index
    @total_users = User.count
    @total_products = Product.count
    @total_inquiries = Inquiry.count
    @total_sellers = User.seller.count
    @total_buyers = User.buyer.count
    @recent_products = Product.latest.limit(5)
    @recent_inquiries = Inquiry.latest.limit(5)
  end
end