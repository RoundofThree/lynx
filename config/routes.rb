Rails.application.routes.draw do
  # bank account detail page route
  get 'bank_account/index'

  # default page for not logged user
  root to: 'home#index'
  # dashboard of logged in user
  get 'dashboard', to: 'dashboard#index'

  resources :accounts, only: [:show, :new, :create, :edit, :update] do
    resources :transactions, only: [:new, :create]
  end
   # transactions can't be edited, updated or destroyed by normal user
  resources :transactions, only: [:show]

  # admin module, full resources privileges for admin
  namespace :admin do
    resources :styles, :users, :accounts, :transactions
  end
  get 'admin', to: 'admin/dashboard#index'
  get 'admin/dashboard', to: 'admin/dashboard#index'
  
  # account detail page 
  get 'accounts', to: 'accounts#show'

  # Devise controllers
  devise_for :users, controllers: {
    sessions: 'users/sessions', # login, logout
    passwords: 'users/passwords', # change password
    registrations: 'users/registrations' # sign up, delete user, update details
  }
end
