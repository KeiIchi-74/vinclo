class Users::PreRegistrationsController < Users::ApplicationController
  layout 'devise'
  def index
    @resource = flash[:resource]
  end
end
