# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super do
      flash[:notice] = nil
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super do
      flash[:notice] = nil
    end
  end

  def new_guest
    guest = User.find_or_create_by(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
      user.birth_date = 19_300_101
    end
    sign_in guest
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
