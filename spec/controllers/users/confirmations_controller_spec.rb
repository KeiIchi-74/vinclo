require 'rails_helper'

RSpec.describe Users::ConfirmationsController, type: :controller do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end
end
