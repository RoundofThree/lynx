Rails.application.routes.draw do
  # default page for not logged user
  root to: 'home#index'
  # dashboard of logged in user
  get 'dashboard', to: 'dashboard#index'
  
  resources :accounts, only: %i[show]
  # transactions can't be edited, updated or destroyed by normal user
  resources :transactions, only: %i[new create show]

  # admin login, logout
  get 'admin/login', to: 'admin/sessions#new'
  post 'admin/login', to: 'admin/sessions#create'
  delete 'admin/logout', to: 'admin/sessions#destroy'

  # admin module, full resources privileges for admin
  namespace :admin do
    resources :users, :accounts, :transactions, :dealers
    get 'styles/edit', to: 'styles#edit'
    put 'styles', to: 'styles#update'
  end
  get 'admin', to: 'admin/dashboard#index'
  get 'admin/dashboard', to: 'admin/dashboard#index'
  post 'admin/generator/generate_transactions' # transaction generator

  # Devise controllers
  devise_for :users, :skip => [:registrations, :passwords], controllers: {
    sessions: 'users/sessions'
  }
  as :user do
    get 'users/sign_up' => 'users/registrations#new', :as => 'new_user_registration'
    post 'users' => 'users/registrations#create', :as => 'user_registration'
    get 'users/password/new' => 'users/passwords#new', :as => 'new_user_password'
    post 'users/password' => 'users/passwords#create', :as => 'user_password'
  end
end
