require 'rails_helper'

RSpec.feature 'Sign up', type: :feature do
  background do
    ActionMailer::Base.deliveries.clear
  end

  def extract_confirmation_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end

  scenario '正しい情報を入力すれば仮登録メールが送信されて、そのリンクに正しく入力すればトップページに移動し、ログアウト、ログインが行える' do
    visit root_path
    expect(page).to have_content('新規会員登録')
    click_link '新規会員登録'
    fill_in 'user_email', with: 'sample@sample.com'
    select '1930', from: 'user_birth_date_1i'
    select '1', from: 'user_birth_date_2i'
    select '1', from: 'user_birth_date_3i'
    fill_in 'user_password', with: '00000a'
    fill_in 'user_password_confirmation', with: '00000a'

    # メールが送信される
    expect { click_button 'regis-submit-1' }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content('仮登録メール送付')

    # メール内のリンク(url)をとりだす
    mail = ActionMailer::Base.deliveries.last
    url = extract_confirmation_url(mail)
    visit url
    expect(page).to have_content('メールアドレスでログイン')
    fill_in 'user_email', with: 'sample@sample.com'
    fill_in 'user_password', with: '00000a'
    click_button 'ログイン'
    expect(page).to have_content('ログアウト')

    # ログアウト
    click_link 'ログアウト'
    expect(page).to have_content('ログイン')

    # 新規会員登録をおこなった後そのユーザーデータでログイン
    click_link 'ログイン'
    fill_in 'user_email', with: 'sample@sample.com'
    fill_in 'user_password', with: '00000a'
    click_button 'ログイン'
    expect(page).to have_content('ログアウト')
  end
end
