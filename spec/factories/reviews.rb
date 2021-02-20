FactoryBot.define do
  factory :review do
    title    { 'サンプルレビューのタイトルです。' }
    score    { 3 }
    text     { 'サンプルレビューのテキストです。'}
    association :cloth_store
    association :user, :authenticated_user
  end
end