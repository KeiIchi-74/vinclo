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
    end
  end
end
