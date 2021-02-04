require 'rails_helper'

RSpec.feature 'Sign up by omniauth', type: :feature do
  background do
    ActionMailer::Base.deliveries.clear
    Rails.application.env_config["omniauth.auth"] = set_omniauth
  end
  scenario 'omniauthを用いて、メールアドレスを入力して、正しい情報を入力すればメールが送信され、そのリンクを押せば会員登録が完了する' do
    visit root_path
    click_link '新規会員登録'
    expect(page).to have_content('他のサービス（メールアドレス）を用いて新規会員登録')
    expect { click_link 'Google' }.to change { SnsCredential.count }.by(1)

    # SnsCredentialテーブルに値が正しく入っているかの確認
    sns_info = SnsCredential.first
    expect(sns_info.provider).to eq 'google_oauth2'
    expect(sns_info.uid).to eq '12345678910'

    # user_idに関しては、ログインの際にomniauthを用いることで登録される
    expect(sns_info.user_id).to eq nil
    expect(current_path).to eq user_google_oauth2_omniauth_callback_path

    # グーグルから送信されたユーザーのメールアドレスが、入力されている
    expect(page).to have_field('user_email', with: 'sample@sample.com')
    
    # 情報を正しく入力する
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
  end
end