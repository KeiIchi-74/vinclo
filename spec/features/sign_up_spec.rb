require 'rails_helper'

RSpec.feature 'Sign up', type: :feature do
  background do
    ActionMailer::Base.deliveries.clear
  end

  scenario '正しい情報を入力すれば仮登録メールが送信されて、そのリンクを押せば、会員登録が完了する' do
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
    expect(User.count).to eq 1

    # 認証カラムの値は空になっている
    expect(User.first.confirmed_at).to eq nil
    expect(page).to have_content('会員登録用メール送付')

    # メール内のリンク(url)をとりだす
    mail = ActionMailer::Base.deliveries.last
    url = extract_confirmation_url(mail)
    visit url

    # リンク先のページに遷移するとユーザーの認証カラムに値が入る
    expect(User.first.confirmed_at).to_not eq nil
    expect(page).to have_content('会員登録が完了しました。')

    # 登録が完了したユーザーが、再びメールのリンクをクリックした場合に、登録完了を知らせるページに遷移する
    visit url
    expect(page).to have_content('メールアドレスは既に登録済みです。ログインしてください。')
  end 
end
