FactoryBot.define do
  factory :user do
    email                 { 'sample1@sample.com' }
    password              { '00000a' }
    password_confirmation { password }
    birth_date            { '1930-01-01' }
  end
  factory :another_user, class: User do
    email                 { 'sample2@sample.com' }
    password              { '00000b' }
    password_confirmation { password }
    birth_date            { '1930-01-02' }
  end
  factory :authenticated_user, class: User do
    email                 { 'sample3@sample.com' }
    password              { '00000c' }
    password_confirmation { password }
    birth_date            { '1930-01-03' }
    confirmed_at          { Time.now }
  end
  factory :authenticated_user_have_omniauth_email, class: User do
    email                 { 'sample@sample.com' }
    password              { '00000d' }
    password_confirmation { password }
    birth_date            { '1930-01-04' }
    confirmed_at          { Time.now }
  end
end
