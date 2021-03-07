class Cloth < ApplicationRecord
  belongs_to :review, optional: true
  REGISTRABLE_ATTRIBUTES = %i[register cloth_name price review_id].freeze
  attr_accessor :register

  validates :price, format: {
    with: /\A\d+\z/,
    message: 'を半角数字で入力してください。',
    allow_blank: true
  }
end
