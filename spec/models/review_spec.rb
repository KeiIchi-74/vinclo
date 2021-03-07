require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'レビュースコープ' do
    it 'find_by_store_prefectureスコープに一致したインスタンスを取得する' do
      review = FactoryBot.create(:review)
      expect(Review.find_by_store_prefecture({ id: 13 })).to include(review)
    end
  end
end
