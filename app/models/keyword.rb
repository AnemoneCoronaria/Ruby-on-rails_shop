class Keyword < ApplicationRecord
  CATEGORY_ICONS = {
    "패션" => "bag",
    "전자기기" => "cpu",
    "식품" => "basket",
    "뷰티" => "stars",
    "홈/리빙" => "house",
    "스포츠" => "bicycle",
    "반려동물" => "heart",
    "도서" => "book"
  }.freeze

  has_and_belongs_to_many :users, join_table: :user_keywords
  has_and_belongs_to_many :products, join_table: :product_keywords

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true

  # 인기 키워드 (상품이 많은 순)
  def self.popular
    joins(:products).group(:id).order("COUNT(products.id) DESC")
  end

  # 카테고리별 그룹화
  def self.grouped
    all.group_by(&:category)
  end

  def self.categories
    select("DISTINCT ON (category) *").order(:category)
  end

  def icon
    CATEGORY_ICONS[category] || "tag"
  end
end
