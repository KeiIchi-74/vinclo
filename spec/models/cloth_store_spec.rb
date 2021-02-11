require 'rails_helper'

RSpec.describe ClothStore, type: :model do
  before do
    @cloth_store = FactoryBot.build(:cloth_store)
  end

  describe '古着屋情報の登録' do
    context '古着屋登録がうまくいく時' do
      it 'name、name_kana、postcodeが正しく入力されていれば登録できる' do
        expect(@cloth_store).to be_valid
      end
    end

    context '古着屋登録がうまくいかない時' do
      it 'nameが空だと登録できない' do
        @cloth_store.name = ''
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:name]).to include('を入力してください')
      end
      it 'name_kanaが空だと登録できない' do
        @cloth_store.name_kana = ''
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:name_kana]).to include('を入力してください')
      end
      it 'name_kanaが全角（漢字）での入力だと登録できない' do
        @cloth_store.name_kana = '古着'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:name_kana]).to include('を全角カタカナで入力してください。')
      end
      it 'name_kanaが全角（ひらがな）での入力だと登録できない' do
        @cloth_store.name_kana = 'ふるぎ'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:name_kana]).to include('を全角カタカナで入力してください。')
      end
      it 'name_kanaが全角（数字）での入力だと登録できない' do
        @cloth_store.name_kana = '１１'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:name_kana]).to include('を全角カタカナで入力してください。')
      end
      it 'name_kanaが全角（記号）での入力だと登録できない' do
        @cloth_store.name_kana = '＠＠'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:name_kana]).to include('を全角カタカナで入力してください。')
      end
      it 'name_kanaが半角（英字）での入力だと登録できない' do
        @cloth_store.name_kana = 'aa'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:name_kana]).to include('を全角カタカナで入力してください。')
      end
      it 'name_kanaが半角（数字）での入力だと登録できない' do
        @cloth_store.name_kana = '11'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:name_kana]).to include('を全角カタカナで入力してください。')
      end
      it 'name_kanaが半角（記号）での入力だと登録できない' do
        @cloth_store.name_kana = '@@'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:name_kana]).to include('を全角カタカナで入力してください。')
      end
      it 'postcodeが空だと登録できない' do
        @cloth_store.postcode = ''
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:postcode]).to include('を入力してください')
      end
      it 'postcodeが半角のハイフンを含んでいないと登録できない' do
        @cloth_store.postcode = '1234567'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:postcode]).to include('を半角数字で、ハイフンを含めて入力して下さい。')
      end
      it 'postcodeが全角（漢字）だと登録できない' do
        @cloth_store.postcode = '壱'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:postcode]).to include('を半角数字で、ハイフンを含めて入力して下さい。')
      end
      it 'postcodeが全角（ひらがな）だと登録できない' do
        @cloth_store.postcode = 'いち'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:postcode]).to include('を半角数字で、ハイフンを含めて入力して下さい。')
      end
      it 'postcodeが全角（カタカナ）だと登録できない' do
        @cloth_store.postcode = 'イチ'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:postcode]).to include('を半角数字で、ハイフンを含めて入力して下さい。')
      end
      it 'postcodeが全角（数字）だと登録できない' do
        @cloth_store.postcode = '１２３４５６７'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:postcode]).to include('を半角数字で、ハイフンを含めて入力して下さい。')
      end
      it 'postcodeが全角（記号）だと登録できない' do
        @cloth_store.postcode = '＠＠'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:postcode]).to include('を半角数字で、ハイフンを含めて入力して下さい。')
      end
      it 'postcodeが半角（英字）だと登録できない' do
        @cloth_store.postcode = 'aa'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:postcode]).to include('を半角数字で、ハイフンを含めて入力して下さい。')
      end
      it 'postcodeが半角（記号）だと登録できない' do
        @cloth_store.postcode = '@@'
        @cloth_store.valid?
        expect(@cloth_store.errors.messages[:postcode]).to include('を半角数字で、ハイフンを含めて入力して下さい。')
      end
    end
  end
end
