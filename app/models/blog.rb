class Blog < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_one_attached :image
    has_rich_text :content
    
    validates :title, presence: true, length: { minimum: 5 }
    validates :author, presence: true
    validate :content_plain_text_min_length

    scope :ordered, -> { order(updated_at: :desc) }

    private
        def content_plain_text_min_length
            if content.blank? || content.body.to_plain_text.strip.length < 50
                errors.add(:content, "must be at least 50 characters of text")
            end
        end
end
