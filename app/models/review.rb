class Review < ApplicationRecord
  belongs_to :user
  belongs_to :cloth_store
  has_many_attached :images, dependent: :destroy
  with_options presence: true do
    validates :score
    validates :title
    validates :text
  end
end
