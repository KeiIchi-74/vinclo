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

  get 'cloth_stores/create', to: 'users/cloth_stores#new'
  post 'cloth_stores/create', to: 'users/cloth_stores#create'

  scope module: :users do
    resources :cloth_stores, only: [:new, :show]
    resources :reviews, only: [:new]
    resources :prefectures, only: [:show] do
      member do
        resources :reviews, only: [:index]
      end
    end
  end
  post 'reviews/create', to: 'users/reviews#create'
  post 'reviews/upload_image', to: 'users/reviews#upload_image'
  get 'reviews/close', to: 'users/reviews#close'
  get 'reviews/show_more_text', to: 'users/reviews#show_more_text'
end
