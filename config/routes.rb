Rails.application.routes.draw do
  resources :users
  resources :articles do
    resources :comments
  end
  resources :comments
  resources :file_uploads
  resources :audit_logs, only: [:index, :show]
  
  # Additional routes for vulnerability demonstration
  post 'login', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
  get 'dashboard', to: 'dashboard#index'

  get 'forgot_password', to: 'sessions#forgot_password'
  post 'reset_password', to: 'sessions#reset_password'
  
  # Dangerous path for SSRF
  get 'proxy', to: 'proxy#index'
  post 'proxy', to: 'proxy#fetch'
  
  post 'file_uploads/import_data', to: 'file_uploads#import_data'

  
  root 'articles#index'
end