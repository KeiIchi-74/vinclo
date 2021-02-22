require 'rails_helper'

RSpec.feature 'Photo Preview', type: :feature do
  # 事前にアップロードする際に、トークンが必要となるので、それを設定する
  background do
    ActionController::Base.allow_forgery_protection = true
    @user = FactoryBot.create(:user, :authenticated_user)
    @cloth_store = FactoryBot.create(:cloth_store)
    sign_in(@user)
  end
  # 他のテストには、影響を及ばさないように設定をはずす
  after do
    ActionController::Base.allow_forgery_protection = false
  end
  scenario 'レビュー登録ページにて、写真を追加するアイコンをクリックして追加すると、そのプレビューが表示される', js: true do
    visit cloth_store_path(@cloth_store.id)
    expect(page).to have_content('店舗情報（詳細）')
    click_link 'レビューを投稿する'
    expect(page).to have_selector('#photo-preview-area')
    # 最初はプレビュー描画されたときに存在する要素はない
    expect(page).to_not have_selector('photo-preview')
    # テスト用の3枚の画像へのパスを定義
    image1_path = Rails.root.join('spec/files/test1.jpg')
    image2_path = Rails.root.join('spec/files/test2.jpg')
    image3_path = Rails.root.join('spec/files/test3.jpg')
    # 3枚の画像を追加して、3枚のプレビューが描画されている
    page.attach_file('review_images', [image1_path, image2_path, image3_path], make_visible: true)
    sleep 0.2
    expect(all('.photo-preview').length).to eq 3
    # 削除ボタン（✕）ボタンをクリックするとプレビュー描画がなくなる
    find('.delete-icon', match: :first).click
    expect(all('.photo-preview').length).to eq 2
    # 編集ボタンに対応した、編集用のinput要素に画像を添付すると、プレビュー画像の全枚数は変化しない
    page.attach_file(image1_path, make_visible: true, class: 'edit-image-file-input', match: :first)
    sleep 0.2
    expect(all('.photo-preview').length).to eq 2
    # エラーによって再レンダリングされると、入力した画像が描画されている
    find('#rmw-footer-button').click
    sleep 0.2
    expect(all('.photo-preview').length).to eq 2
    # すべての合計枚数が4枚を超える画像をアップロードしようとするとプレビューは新たに生成されない
    page.attach_file('review_images', [image1_path, image2_path, image3_path], make_visible: true)
    sleep 0.2
    expect(all('.photo-preview').length).to eq 2
  end
end
