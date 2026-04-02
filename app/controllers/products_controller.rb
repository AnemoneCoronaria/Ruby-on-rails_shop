class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :require_seller!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  def index
    @products = Product.all

    # 카테고리 필터 (추가)
    if params[:category].present?
      category_keywords = Keyword.where(category: params[:category]).pluck(:name)
      @products = @products.with_keywords(category_keywords)
    end

    # 매칭된 상품만 필터
    if params[:matched] == "true" && user_signed_in? && current_user.keywords.any?
      @products = @products.with_keywords(current_user.keywords.pluck(:name))
    end

    # 검색
    @products = @products.search(params[:q]) if params[:q].present?

    # 키워드 필터
    if params[:keywords].present?
      @products = @products.with_keywords(Array(params[:keywords]))
    end

    # 가격 범위 필터
    @products = @products.price_between(params[:min_price], params[:max_price])

    # 정렬
    @products = case params[:sort]
    when "popular"    then @products.popular
    when "price_asc"  then @products.price_asc
    when "price_desc" then @products.price_desc
    else                   @products.latest
    end

    # 페이지네이션 (kaminari)
    @products = @products.page(params[:page]).per(12)
  end

  # 신상품 페이지 (추가)
  def new_arrivals
    @products = Product.latest.page(params[:page]).per(12)
    render :index
  end

  # 인기상품 페이지 (추가)
  def popular
    @products = Product.popular.page(params[:page]).per(12)
    render :index
  end

  def show
    @product.increment!(:view_count)
    @related_products = Product.with_keywords(@product.keyword_names)
                                .where.not(id: @product.id)
                                .latest.limit(4)
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to @product, notice: "상품이 등록되었습니다!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # 이미 set_product에서 @product 설정됨
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "상품이 수정되었습니다."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "상품이 삭제되었습니다."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :discount_rate, :image, keyword_ids: [])
  end

  def require_seller!
    redirect_to root_path, alert: "판매자만 접근 가능합니다." unless current_user.seller? || current_user.admin?
  end
end
