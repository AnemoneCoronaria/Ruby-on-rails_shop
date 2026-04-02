class Inquiry < ApplicationRecord
  belongs_to :user
  belongs_to :product, optional: true
  has_many :answers, dependent: :destroy

  # Rails 8 문법으로 enum 수정
  enum :status, { open: 0, answered: 1, closed: 2 }, default: :open

  validates :title, :content, presence: true

  scope :latest, -> { order(created_at: :desc) }
  scope :by_status, ->(s) { s.present? ? where(status: s) : all }
  scope :search, ->(q) {
    q.present? ? where("title LIKE ? OR content LIKE ?", "%#{q}%", "%#{q}%") : all
  }
end
