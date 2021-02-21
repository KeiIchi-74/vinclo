FactoryBot.define do
  factory :review do
    title    { 'サンプルレビューのタイトルです。' }
    score    { 3 }
    text     { 'サンプルレビューのテキストです。'}
    association :cloth_store
    association :user, :authenticated_user
    trait :over_count do
      title  { Faker::Lorem.characters(number: 51) }
      text   { Faker::Lorem.characters(number: 5001) }
    end
  end
end