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

    # 登録されていないメールアドレスを入力すると、メールは送信されない
    fill_in 'user_email', with: 'sample@sample.com'
    expect { click_button 'パスワード再設定用確認メールを送る' }.to change { ActionMailer::Base.deliveries.size }.by(0)
    expect(page).to have_content('メールアドレスは見つかりませんでした')
    
    # メールが送信される
    fill_in 'user_email', with: @user.email
    expect { click_button 'パスワード再設定用確認メールを送る' }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content('パスワード再設定用確認メール送付')

    # メール内のリンク（url)をとりだす
    mail = ActionMailer::Base.deliveries.last
    url = extract_confirmation_url(mail)
    visit url
    expect(page).to have_content('新しいパスワードを設定してください')

    # passwordとpassword_confirmationの値を適切に入力しなかった場合、エラー文が表示される
    fill_in 'user_password', with: 'あああああ'
    fill_in 'user_password_confirmation', with: 'いいいいいい'
    click_button 'パスワードを再設定する'
    expect(page).to have_content('パスワードは6文字以上で入力してください')
    expect(page).to have_content('パスワードは半角英字と半角数字の両方を含めて入力してください')
    expect(page).to have_content('パスワード【確認用】とパスワードの入力が一致しません')

    # 再設定が行われるとログインしてトップページに遷移する
    fill_in 'user_password', with: '12345a'
    fill_in 'user_password_confirmation', with: '12345a'
    click_button 'パスワードを再設定する'
    expect(current_path).to eq root_path
    expect(page).to have_content('パスワードが正しく変更されました。')
    expect(page).to have_content('ログアウト')
    click_link 'ログアウト'

    # 再設定したパスワードを用いて、ログインが行える
    click_link 'ログイン'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: '12345a'
    click_button 'ログイン'
    expect(current_path).to eq root_path
    expect(page).to have_content('ログアウト')

    # パスワード再設定後に、メールのリンクを再度クリックすると、トップページにリダイレクトされる
    visit url
    expect(current_path).to eq root_path
  end
end
