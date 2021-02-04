require 'rails_helper'

RSpec.feature 'Sign in by omniauth', type: :feature do
  background do
    Rails.application.env_config["omniauth.auth"] = set_omniauth
  end

  scenario 'omniauthに登録されているメールアドレスで会員登録していれば、omniauthを用いたログインが行える' do
    FactoryBot.create(:authenticated_user_have_omniauth_email)
    visit root_path
    click_link 'ログイン'
    expect(page).to have_content('他のサービスでログイン')
    click_link 'Google'
    expect(current_path).to eq root_path
    expect(page).to have_content('ログアウト')
  end
  scenario 'omniauthに登録されていないメールアドレスで会員登録していれば、omniauthを用いたログインは行えず、新規会員登録ページに遷移する' do
    FactoryBot.create(:authenticated_user)
    visit root_path
    click_link 'ログイン'
    expect(page).to have_content('他のサービスでログイン')
    click_link 'Google'

    # omniauthユーザーメールアドレスとは、一致しないため、新規会員登録ページに遷移し、omniauthのメールアドレスが入力されている
    expect(current_path).to eq user_google_oauth2_omniauth_callback_path
    expect(page).to have_field('user_email', with: 'sample@sample.com')
  end
end