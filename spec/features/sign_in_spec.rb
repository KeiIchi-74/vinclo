require 'rails_helper'

RSpec.feature 'Sign in', type: :feature do
  background do
    @user = FactoryBot.create(:authenticated_user)
  end

  scenario '登録したユーザー情報を正しく入力すれば、ログインできる' do
    visit root_path
    click_link 'ログイン'
    expect(page).to have_content('メールアドレスでログイン')
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'ログイン'
    expect(current_path).to eq root_path
  end
  scenario '登録していないユーザ情報を入力すれば、ログインできない' do
    visit root_path
    click_link 'ログイン'
    expect(page).to have_content('メールアドレスでログイン')
    fill_in 'user_email', with: 'sample@sample.com'
    fill_in 'user_password', with: '12345a'
    click_button 'ログイン'
    expect(page).to have_content('メールアドレスまたはパスワードが違います。')
  end
end