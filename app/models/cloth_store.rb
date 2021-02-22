class ClothStore < ApplicationRecord
  include JpPrefecture
  has_many :reviews
  with_options presence: true do
    validates :name
    validates :name_kana, format: {
      with: /\A[ァ-ン]+\z/,
      message: 'を全角カタカナで入力して下さい。'
    }
    validates :postcode, format: {
      with: /\A[0-9]{3}-[0-9]{4}\z/,
      message: 'を半角数字で、ハイフンを含めて入力して下さい。'
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
    prefecture = prefecture_name
    [name, prefecture, address_city, address_street].compact.join(', ')
  end

  def address_display
    prefecture = prefecture_name
    [prefecture, address_city, address_street].compact.join
  end
end
