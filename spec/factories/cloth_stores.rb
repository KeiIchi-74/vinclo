FactoryBot.define do
  factory :cloth_store do
    name       { 'Vinclo' }
    name_kana  { 'ビンクロ' }
    postcode   { '123-4567' }
    prefecture_code { 13 }
  end
end
