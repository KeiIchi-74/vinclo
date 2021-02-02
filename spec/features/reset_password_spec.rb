require 'rails_helper'

RSpec.feature 'Reset Password', type: :feature do
  background do
    ActionMailer::Base.deliveries.clear
    @user = FactoryBot.create(:authenticated_user)
  end

  def extract_confirmation_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end

  scenario '登録したメールアドレス宛に、パスワード再設定用のリンクが送信されて、その遷移先でパスワードを正しく入力すれば、再設定されてログインが行われる' do
    # パスワード再設定
    visit root_path
    expect(page).to have_content('ログイン')
    click_link 'ログイン'
    expect(page).to have_content('パスワードをお忘れの方はこちら')
    click_link 'パスワードをお忘れの方はこちら'
    expect(page).to have_content('パスワード再設定')
    fill_in 'user_email', with: @user.email

    # メールが送信される
    expect { click_button 'パスワード再設定用確認メールを送る' }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content('パスワード再設定用確認メール送付')

    # メール内のリンク（url)をとりだす
    mail = ActionMailer::Base.deliveries.last
    url = extract_confirmation_url(mail)
    visit url
    expect(page).to have_content('新しいパスワードを設定してください')
    fill_in 'user_password', with: '12345a'
    fill_in 'user_password_confirmation', with: '12345a'

    # 再設定が行われるとログインしてトップページに遷移する
    click_button 'パスワードを再設定する'
    expect(page).to have_content('ログアウト')
    click_link 'ログアウト'
    expect(page).to have_content('ログイン')

    # 再設定したパスワードを用いて、ログインが行える
    click_link 'ログイン'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: '12345a'
    click_button 'ログイン'
    expect(page).to have_content('ログアウト')
  end
end
