require 'rails_helper'

RSpec.feature 'Cloth Form', type: :feature do
  background do
    @user = FactoryBot.create(:user, :authenticated_user)
    @cloth_store = FactoryBot.create(:cloth_store)
    sign_in(@user)
  end
  scenario 'レビュー登録フォームにて、古着屋で購入した服の情報を入力する欄を追加、削除することができる', js: true do
    visit cloth_store_path(@cloth_store.id)
    expect(page).to have_content('店舗情報（詳細）')
    click_link 'レビューを投稿する'
    expect(page).to have_selector('.rmw-main-cloth-container')
    # 最初は、服情報入力欄はひとつで、入力欄追加ボタンしかない
    expect(all('.rmw-main-cloth-container').length).to eq 1
    expect(page).to have_selector('.cloth-form-add-content')
    expect(page).to_not have_selector('.cloth-form-remove-content')
    # 入力欄追加ボタンを押すと、入力欄が1つ追加されて、削除ボタンが表示される
    target = page.find('.cloth-form-add-content')
    target.click
    expect(all('.rmw-main-cloth-container').length).to eq 2
    expect(page).to have_selector('.cloth-form-remove-content')
    # 入力欄が全部で4つになると、入力欄追加ボタンは表示されない
    2.times do
      target.click
    end
    expect(all('.rmw-main-cloth-container').length).to eq 4
    expect(page).to_not have_selector('.cloth-form-add-content')
    # 入力欄が1つになると、入力欄削除ボタンは表示されない
    target = page.find('.cloth-form-remove-content')
    3.times do
      target.click
    end
    expect(page).to_not have_selector('.cloth-form-remove-content')
    # 不適切な値を入力した場合に、不適切な値を入力した欄の数でけエラーメッセージが表示される
    target = page.find('.cloth-form-add-content')
    3.times do
      target.click
    end
    expect(all('.rmw-main-cloth-container').length).to eq 4
    fill_in 'review_form_cloths_attributes_1_price', with: 'サンプル'
    fill_in 'review_form_cloths_attributes_3_price', with: 'サンプル'
    sleep 3
    page.find('#rmw-footer-button').click
    expect(page).to have_content('値段を半角数字で入力してください。')
    # 2つの入力欄にて、不適切な値を入力したため、エラー文が2つ表示されている
    expect(find('#cloth-form-price-error-1')).to have_content('値段を半角数字で入力してください。')
    expect(find('#cloth-form-price-error-3')).to have_content('値段を半角数字で入力してください。')
  end
end
