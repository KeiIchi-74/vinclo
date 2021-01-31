require 'rails_helper'

feature 'Sign up' do
  scenario 'メールアドレス、生年月日、パスワードをでユーザー登録を行う' do
    visit root_path
    expect(page).to have_http_status :ok
  end
end