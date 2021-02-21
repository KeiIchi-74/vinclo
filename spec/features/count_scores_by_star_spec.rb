require 'rails_helper'

RSpec.feature 'Count Scores By Star', type: :feature do
  background do
    @user = FactoryBot.create(:user, :authenticated_user)
    @cloth_store = FactoryBot.create(:cloth_store)
    sign_in(@user)
  end
  scenario 'レビュー登録フォームにて、店舗の5段階評価をスターアイコンをホバー、またはクリックすることで入力することができる', js: true do
    visit cloth_store_path(@cloth_store.id)
    expect(page).to have_content('店舗情報（詳細）')
    click_link 'レビューを投稿する'
    expect(page).to have_selector('#c-overlay')
    expect(page).to have_selector('.score-contents')
    expect(page).to have_css('.far.fa-star.fs-30')
    # 最初はどのstarのアイコンのクラスはfar（くり抜かれたスター、色のついていない）である
    expect(all('.far.fa-star.fs-30').length).to eq 5
    # 5つのスターアイコンのうち三番目の星（評価3に該当）するものをホバーすると、3つのスターアイコンのクラスはfas（色が塗りつぶされたデザイン）に変更する
    target = page.find('#star-score-3')
    target.hover
    expect(all('.fas.fa-star.fs-30').length).to eq 3
    # 3つのスターアイコンが塗りつぶされて、inputのscoreを送信する値に3が代入されている
    expect(find('#score-value', visible: false).value).to eq '3'
    # アイコンの右隣の表示が3に変化している
    expect(find('#score-value-display').text).to eq '3'
    # 次に2つめのスターアイコンにホバーすると、3つ目の塗りつぶされていた要素はくり抜かれたものに変化して、input要素のvalueも2に変化する
    target = page.find('#star-score-2')
    target.hover
    # 色付きが2つ
    expect(all('.fas.fa-star.fs-30').length).to eq 2
    # 色なしが3つ
    expect(all('.far.fa-star.fs-30').length).to eq 3
    expect(find('#score-value', visible: false).value).to eq '2'
    expect(find('#score-value-display').text).to eq '2'
  end
end
