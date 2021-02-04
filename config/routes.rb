Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    omniauth_callbacks: "users/omniauth_callbacks",
  }
  root 'users/home#index'
  get 'users/pre_registrations', to: 'users/pre_registrations#index'
  get 'users/pre_reset_passwords', to: 'users/pre_reset_passwords#index'
end
