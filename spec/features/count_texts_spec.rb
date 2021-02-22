require 'rails_helper'

RSpec.feature 'Count Texts', type: :feature do
  background do
    @user = FactoryBot.create(:user, :authenticated_user)
    @cloth_store = FactoryBot.create(:cloth_store)
    @review = FactoryBot.build(:review, :over_count)
    sign_in(@user)
  end
  scenario 'レビュー登録ページにて、レビュータイトル、レビュー本文にて文字を入力するとその文字数がカウントされる', js: true do
    visit cloth_store_path(@cloth_store.id)
    expect(page).to have_content('店舗情報（詳細）')
    click_link 'レビューを投稿する'
    expect(page).to have_field('rmw-main-title-textarea')
    expect(page).to have_field('rmw-main-text-textarea')
    # レビュータイトルの最初の文字数表示は0である
    expect(find('#title-count').text).to eq '0'
    # レビュータイトルにサンプルと入力すると、文字数が4として表示される
    fill_in 'rmw-main-title-textarea', with: 'タイトルサンプル'
    expect(find('#title-count').text).to eq '8'
    # レビュータイトルに50文字以上の入力をすると、文字数が50として表示される
    fill_in 'rmw-main-title-textarea', with: @review.title
    expect(find('#title-count').text).to eq '50'
    # レビュー本文の最初の文字数表示は0である
    expect(find('#text-count').text).to eq '0'
    # レビュー本文にサンプルと入力すると、文字数が0として表示される
    fill_in 'rmw-main-text-textarea', with: '本文サンプル'
    expect(find('#text-count').text).to eq '6'
    # レビュー本文に5000文字以上の入力をすると、文字数が5000として表示される
    fill_in 'rmw-main-text-textarea', with: @review.text
    expect(find('#text-count').text).to eq '5000'
  end
end
