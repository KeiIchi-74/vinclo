Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'users/home#index'
  get 'users/pre_registrations', to: 'users/pre_registrations#index'
end
