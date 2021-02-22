FactoryBot.define do
  factory :user do
    email                 { 'sample1@sample.com' }
    password              { '00000a' }
    password_confirmation { password }
    birth_date            { '1930-01-01' }
    trait :another_user do
      email                 { 'sample2@sample.com' }
    end
    trait :authenticated_user do
      confirmed_at          { Time.now }
    end
    trait :authenticated_user_have_omniauth_email do
      email                 { 'sample@sample.com' }
      confirmed_at          { Time.now }
    end
  end
end
