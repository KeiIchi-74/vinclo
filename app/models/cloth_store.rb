class ClothStore < ApplicationRecord
  include JpPrefecture
  has_many :reviews
  with_options presence: true do
    validates :name
    validates :name_kana, format: {
      with: /\A[ァ-ン]+\z/,
      message: 'を全角カタカナで入力してください。'
    }
    validates :postcode, format: {
      with: /\A[0-9]{3}-[0-9]{4}\z/,
      message: 'を半角数字で、ハイフンを含めて入力してください。'
    }
  end
  jp_prefecture :prefecture_code
  geocoded_by :address
  after_validation :geocode

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def address
    [name, prefecture_name, address_city, address_street].compact.join
  end

  def address_display
    [prefecture_name, address_city, address_street].compact.join
  end

  def avg_score
    if reviews.empty?
      0.0
    else
      reviews.average(:score).round(1).to_f
    end
  end

  def avg_price
    if reviews.cloths.pluck(:price).empty?
      '価格は登録されていません'
    else
      "#{reviews.cloths.average(:price).floor}円"
    end
  end

  def reviews_score_percentage
    if reviews.empty?
      0.0
    else
      reviews.average(:score).round(1).to_f * 100 / 5
    end
  end

  def latest_review_title
    if reviews.empty?
      'レビューは投稿されていません'
    else
      reviews&.last&.title
    end
  end

  def latest_review_text
    reviews.last.text.truncate(40) unless reviews.empty?
  end

  def reviews_count
    reviews.length
  end
end
