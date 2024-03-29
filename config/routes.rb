Rails.application.routes.draw do
  get 'products/search', to: 'products#search'
  resources :products do
    resource :favorites, only: [:create, :destroy]
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
    get 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root 'products#index'
  get 'users/home', to: 'users#home'
  get 'users/edit_profile', to: 'users#edit_profile'
  patch 'users/profile_update', to: 'users#profile_update'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
