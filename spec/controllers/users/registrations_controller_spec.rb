require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe '#new' do
    it '200レスポンスを返すこと' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      get :new
      expect(response).to have_http_status '200'
    end
  end
end
