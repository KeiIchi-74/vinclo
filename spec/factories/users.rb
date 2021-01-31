FactoryBot.define do
  factory :user do
    email                 {'sample1@sample'}
    password              {'00000a'}
    password_confirmation {password}
    birth_date            {'1930-01-01'}
  end
  factory :another_user, class: User do
    email                 {'sample2@sample'}
    password              {'00000b'}
    password_confirmation {password}
    birth_date            {'1930-01-02'}
  end
end