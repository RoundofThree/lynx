Rails.application.routes.draw do
  # default page for not logged user
  root to: 'home#index'
  # dashboard of logged in user
  get 'dashboard', to: 'dashboard#index'

  resources :accounts, only: %i[show new create edit update]
  # transactions can't be edited, updated or destroyed by normal user
  resources :transactions, only: %i[new create show]

  # admin login, logout
  get 'admin/login', to: 'admin/sessions#new'
  post 'admin/login', to: 'admin/sessions#create'
  delete 'admin/logout', to: 'admin/sessions#destroy'

  # admin module, full resources privileges for admin
  namespace :admin do
    resources :users, :accounts, :transactions
    get 'styles/edit', to: 'styles#edit'
    put 'styles', to: 'styles#update'
  end
  get 'admin', to: 'admin/dashboard#index'
  get 'admin/dashboard', to: 'admin/dashboard#index'

  # Devise controllers
  devise_for :users, controllers: {
    sessions: 'users/sessions', # login, logout
    passwords: 'users/passwords', # change password
    registrations: 'users/registrations' # sign up, delete user, update details
  }
end
