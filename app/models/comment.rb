class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  has_rich_text :body
  
  validates :commenter, presence: true
  validate :body_min_length
  
  scope :ordered, -> { order(id: :asc) }
  
  private
    def body_min_length
      if body.blank? || body.to_plain_text.strip.length < 5
        errors.add(:body, "must be at least 5 characters")
      end
    end
end
