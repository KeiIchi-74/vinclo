class Review < ApplicationRecord
  has_many   :cloths
  belongs_to :user
  belongs_to :cloth_store
  has_many_attached :review_images, dependent: :destroy
  with_options presence: true do
    validates :score
    validates :title
    validates :text
  end

  # 古着屋の都道府県コードがパラメーターと一致するレビューを持ってくる
  scope :find_by_store_prefecture, lambda { |params|
    includes(:cloth_store).with_attached_review_images.where(cloth_stores: { prefecture_code: params[:id] })
  }

  def short_text
    text.truncate(60)
  end

  def display_more_btn?
    text.length > 60
  end

  def image_variant_review_index(image)
    image.variant(resize: '150x150^', gravity: :center, crop: '150x150+0+0').processed
  end

  def image_length(image, type)
    image.blob.metadata[type]
  end

  def score_percentage
    score.round(1).to_f * 100 / 5
  end
end
