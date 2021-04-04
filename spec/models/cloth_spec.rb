require 'rails_helper'

RSpec.describe Cloth, type: :model do
  before do
    @cloth = FactoryBot.build(:cloth)
  end

  context '古着屋レビューの投稿' do
    context 'レビュー投稿がうまくいくとき' do
      it 'scoreが正しく入力されていれば投稿できる' do
        expect(@cloth).to be_valid
      end
    end
    context 'レビュー投稿がうまくいかないとき' do
      it 'priceが全角(漢字）だと投稿できない' do
        @cloth.price = '漢字'
        @cloth.valid?
        expect(@cloth.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角(ひらがな）だと投稿できない' do
        @cloth.price = 'ひらがな'
        @cloth.valid?
        expect(@cloth.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角(カタカナ）だと投稿できない' do
        @cloth.price = '漢字'
        @cloth.valid?
        expect(@cloth.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角(カタカナ）だと投稿できない' do
        @cloth.price = '漢字'
        @cloth.valid?
        expect(@cloth.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角数字だと投稿できない' do
        @cloth.price = '１１１１'
        @cloth.valid?
        expect(@cloth.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが全角記号だと投稿できない' do
        @cloth.price = '＠＠＠＠'
        @cloth.valid?
        expect(@cloth.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが半角英字だと投稿できない' do
        @cloth.price = 'aaaa'
        @cloth.valid?
        expect(@cloth.errors[:price]).to include('を半角数字で入力してください。')
      end
      it 'priceが半角記号だと投稿できない' do
        @cloth.price = '@@@@'
        @cloth.valid?
        expect(@cloth.errors[:price]).to include('を半角数字で入力してください。')
      end
    end
  end
end
