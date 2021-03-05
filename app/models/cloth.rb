class Cloth < ApplicationRecord
  belongs_to :review
  validates :price, format: {
    with: /\A\d+\z/,
    message: 'を半角数字で入力してください。',
    allow_blank: true
  }
end
