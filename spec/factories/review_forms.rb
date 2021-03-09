FactoryBot.define do
  factory :review_form do
    title    { 'サンプルレビューのタイトルです。' }
    score    { 3 }
    text     { 'サンプルレビューのテキストです。' }
    after(:build) do |review_form|
      review_form.cloths.each_with_index do |cloth, index|
        cloth.register = "1" if index = 0
      end
    end
  end
end
