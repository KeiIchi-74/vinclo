require 'rails_helper'

RSpec.describe Users::HomeController, type: :controller do
  describe '#index' do
    it '200レスポンスを返すこと' do
      get :index
      expect(response).to have_http_status '200'
    end
  end
end