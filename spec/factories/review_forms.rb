FactoryBot.define do
  factory :review_form do
    title    { 'サンプルレビューのタイトルです。' }
    score    { 3 }
    text     { 'サンプルレビューのテキストです。' }
    cloth_name { 'シャツ' }
    price      { 1234 }
  end
end