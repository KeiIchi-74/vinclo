class Review < ApplicationRecord
  belongs_to :user
  belongs_to :cloth_store
  has_many_attached :images, dependent: :destroy
  with_options presence: true do
    validates :score
    validates :title
    validates :text
  end
  validates :price, format: {
    with: /\A\d+\z/,
    message: 'を半角数字で入力してください。',
    allow_blank: true
  }

  def short_text
    text.truncate(60)
  end
end
