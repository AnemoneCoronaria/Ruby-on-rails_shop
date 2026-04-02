class Product < ApplicationRecord
  belongs_to :seller, class_name: "User"
  has_and_belongs_to_many :keywords, join_table: :product_keywords
  has_one_attached :image

  validates :name, :price, :stock, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :discount_rate, numericality: { in: 0..99 }, allow_nil: true

  # 정렬 스코프
  scope :latest, -> { order(created_at: :desc) }
  scope :popular, -> { order(view_count: :desc) }
  scope :price_asc, -> { order(price: :asc) }
  scope :price_desc, -> { order(price: :desc) }

  # 검색 스코프
  scope :with_keywords, ->(names) {
    joins(:keywords).where(keywords: { name: names }).distinct
  }

  scope :price_between, ->(min, max) {
    where(price: (min.presence || 0)..(max.presence || Float::INFINITY))
  }

  scope :search, ->(q) {
    where("name LIKE ? OR description LIKE ?", "%#{q}%", "%#{q}%")
  }

  def discounted_price
    return price unless discount_rate.to_i > 0
    price * (1 - discount_rate / 100.0)
  end

  def keyword_names
    keywords.pluck(:name)
  end
end
