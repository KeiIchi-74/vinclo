require 'rails_helper'

RSpec.describe ReviewForm, type: :model do
  before do
    @review_form = FactoryBot.build(:review_form)
  end

  describe '古着屋レビューの投稿' do
    context 'レビュー投稿がうまくいくとき' do
      it 'title、score、textが入力されていれば投稿できる' do
        expect(@review_form).to be_valid
      end
    end
    context 'レビュー投稿がうまくいかないとき' do
      it 'titleが空だと投稿できない' do
        @review_form.title = ''
        @review_form.valid?
        expect(@review_form.errors[:title]).to include('を入力してください')
      end
      it 'scoreが空だと投稿できない' do
        @review_form.score = ''
        @review_form.valid?
        expect(@review_form.errors[:score]).to include('を入力してください')
      end
      it 'textが空だと投稿できない' do
        @review_form.text = ''
        @review_form.valid?
        expect(@review_form.errors[:text]).to include('を入力してください')
      end
      it 'priceが全角(漢字）だと投稿できない' do
        @review_form.price = '漢字'
        @review_form.valid?
        expect(@review_form.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角(ひらがな）だと投稿できない' do
        @review_form.price = 'ひらがな'
        @review_form.valid?
        expect(@review_form.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角(カタカナ）だと投稿できない' do
        @review_form.price = '漢字'
        @review_form.valid?
        expect(@review_form.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角(カタカナ）だと投稿できない' do
        @review_form.price = '漢字'
        @review_form.valid?
        expect(@review_form.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角数字だと投稿できない' do
        @review_form.price = '１１１１'
        @review_form.valid?
        expect(@review_form.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角記号だと投稿できない' do
        @review_form.price = '＠＠＠＠'
        @review_form.valid?
        expect(@review_form.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが半角英字だと投稿できない' do
        @review_form.price = 'aaaa'
        @review_form.valid?
        expect(@review_form.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが半角記号だと投稿できない' do
        @review_form.price = '@@@@'
        @review_form.valid?
        expect(@review_form.errors[:price]).to include('を半角数字で入力してください。')
      end
    end
  end
end
