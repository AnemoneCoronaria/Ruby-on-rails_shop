class Answer < ApplicationRecord
  belongs_to :inquiry
  belongs_to :user

  validates :content, presence: true

  after_create :mark_inquiry_answered

  private

  def mark_inquiry_answered
    inquiry.answered! if inquiry.open?
  end
end
