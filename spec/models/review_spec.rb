require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @review = FactoryBot.build(:review)
  end

  describe '古着屋レビューの投稿' do
    context 'レビュー投稿がうまくいくとき' do
      it 'title、score、textが入力されていて、userとcloth_storeに紐付いていれば投稿できる' do
        expect(@review).to be_valid
      end
    end
    context 'レビュー投稿がうまくいかないとき' do
      it 'titleが空だと投稿できない' do
        @review.title = ''
        @review.valid?
        expect(@review.errors[:title]).to include('を入力してください')
      end
      it 'scoreが空だと投稿できない' do
        @review.score = ''
        @review.valid?
        expect(@review.errors[:score]).to include('を入力してください')
      end
      it 'textが空だと投稿できない' do
        @review.text = ''
        @review.valid?
        expect(@review.errors[:text]).to include('を入力してください')
      end
      it 'userが紐付いていないと投稿できない' do
        @review.user = nil
        @review.valid?
        expect(@review.errors[:user]).to include('を入力してください')
      end
      it 'cloth_storeが紐付いていないと投稿できない' do
        @review.cloth_store = nil
        @review.valid?
        expect(@review.errors[:cloth_store]).to include('を入力してください')
      end
      it 'priceが全角(漢字）だと投稿できない' do
        @review.price = '漢字'
        @review.valid?
        expect(@review.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角(ひらがな）だと投稿できない' do
        @review.price = 'ひらがな'
        @review.valid?
        expect(@review.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角(カタカナ）だと投稿できない' do
        @review.price = '漢字'
        @review.valid?
        expect(@review.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角(カタカナ）だと投稿できない' do
        @review.price = '漢字'
        @review.valid?
        expect(@review.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角数字だと投稿できない' do
        @review.price = '１１１１'
        @review.valid?
        expect(@review.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角記号だと投稿できない' do
        @review.price = '＠＠＠＠'
        @review.valid?
        expect(@review.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが半角英字だと投稿できない' do
        @review.price = 'aaaa'
        @review.valid?
        expect(@review.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが半角記号だと投稿できない' do
        @review.price = '@@@@'
        @review.valid?
        expect(@review.errors[:price]).to include('を半角数字で入力してください。')
      end
    end
  end

  describe 'レビュースコープ' do
    it 'find_by_store_prefectureスコープに一致したインスタンスを取得する' do
      review = FactoryBot.create(:review)
      expect(Review.find_by_store_prefecture({ id: 13 })).to include(review)
    end
  end
end
