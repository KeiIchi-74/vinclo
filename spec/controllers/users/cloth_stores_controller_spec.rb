require 'rails_helper'

RSpec.describe Users::ClothStoresController, type: :controller do
  before do
    @user = FactoryBot.build(:authenticated_user)
    sign_in(@user)
  end
  describe '#new' do
    it '200レスポンスを返すこと' do
      get :new
      expect(response).to have_http_status '200'
    end
  end
end
