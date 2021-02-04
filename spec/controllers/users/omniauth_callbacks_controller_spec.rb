require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  describe '#google_oauth2' do
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @request.env['omniauth.auth'] = set_omniauth
    end
      
    it '200レスポンスを返すこと' do
      get :google_oauth2
      expect(response).to have_http_status '200'
    end
  end
end