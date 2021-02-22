require 'rails_helper'

RSpec.feature 'Post Review', type: :feature do
  background do
    ActionController::Base.allow_forgery_protection = true
    @user = FactoryBot.create(:user, :authenticated_user)
    @cloth_store = FactoryBot.create(:cloth_store)
    @review = FactoryBot.build(:review, :data_when_post_review)
    sign_in(@user)
  end
  after do
    ActionController::Base.allow_forgery_protection = false
  end
  scenario 'レビュー登録フォームにて、投稿に必要な情報を入力すれば、投稿が完了して、同一ページにレンダリングされる', js: true do
    visit cloth_store_path(@cloth_store.id)
    expect(page).to have_content('店舗情報（詳細）')
    click_link 'レビューを投稿する'
    expect(page).to have_selector('#c-overlay')
    fill_in 'review_cloth_name', with: @review.cloth_name
    fill_in 'review_price', with: @review.price
    target = page.find('#star-score-3')
    target.hover
    expect(find('#score-value', visible: false).value).to eq '3'
    fill_in 'rmw-main-title-textarea', with: @review.title
    fill_in 'rmw-main-text-textarea', with: @review.text
    image1_path = Rails.root.join('spec/files/test1.jpg')
    page.attach_file('review_images', image1_path, make_visible: true)
    sleep 0.2
    expect(all('.photo-preview').length).to eq 1
    expect do
      find('#rmw-footer-button').click
      find('.flash-success')
    end.to change { Review.count }.by(1)
  end
  scenario 'レビュー登録フォームにて、投稿に必要な情報を入力しないと、投稿が完了せず、エラー文が表示される', js: true do
    visit cloth_store_path(@cloth_store.id)
    expect(page).to have_content('店舗情報（詳細）')
    click_link 'レビューを投稿する'
    expect(page).to have_selector('#c-overlay')
    # すべての項目を空欄で投稿ボタンを押す
    expect do
      find('#rmw-footer-button').click
      find('.review-text-error')
    end.to change { Review.count }.by(0)
    expect(page).to have_content '評価を入力して下さい'
    expect(page).to have_content 'レビュータイトルを入力して下さい'
    expect(page).to have_content 'レビュー本文を入力して下さい'
  end
end
