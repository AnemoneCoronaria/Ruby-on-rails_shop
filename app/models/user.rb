class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Role definitions
  enum :role, { buyer: 0, seller: 1, admin: 2 }, default: :buyer

  # Associations
  has_and_belongs_to_many :keywords, join_table: :user_keywords
  has_many :products, foreign_key: :seller_id, dependent: :nullify
  has_many :inquiries, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_one :wishlist, dependent: :destroy  # ← 이 줄 추가

  # Validations
  validates :name, presence: true
  validates :role, presence: true

  # Callbacks
  after_initialize :set_default_role, if: :new_record?
  after_create :create_cart
  after_create :create_wishlist  # ← 이 줄 추가

  private

  def set_default_role
    self.role ||= :buyer
  end

  def create_cart
    Cart.create(user: self)
  end

  def create_wishlist  # ← 이 메서드 추가
    Wishlist.create(user: self)
  end
end
