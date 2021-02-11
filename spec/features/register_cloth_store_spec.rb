require 'rails_helper'

RSpec.feature 'Register Cloth Store', type: :feature do
  background do
    @user = FactoryBot.create(:authenticated_user)
    sign_in(@user)
  end

  scenario '古着屋登録ページにて、情報を正しく入力すれば登録が行われる', js: true do
    visit new_cloth_store_path
    expect(page).to have_content('古着屋情報入力')
    fill_in 'cloth_store_name', with: 'Vinclo'
    fill_in 'cloth_store_name_kana', with: 'ビンクロ'

    # 郵便番号を入力すると自動で、都道府県や市区町村が入力されている
    fill_in 'cloth_store_postcode', with: '123-4567'
    sleep 0.2
    expect(find_field('cloth_store_prefecture_code').value).to eq '13'
    expect(find_field('cloth_store_address_city').value).to eq '足立区'
    expect { click_button '登録する' }.to change { ClothStore.count }.by(1)

    # gem geocoderによって、緯度、経度の値が保存されている
    expect(ClothStore.last.latitude).to_not be_blank
    expect(ClothStore.last.longitude).to_not be_blank
    expect(current_path).to eq root_path
  end
end
