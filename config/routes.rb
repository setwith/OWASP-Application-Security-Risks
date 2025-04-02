Rails.application.routes.draw do
  resources :users
  resources :articles do
    resources :comments
  end
  resources :file_uploads
  resources :audit_logs, only: [:index, :show]
  
  # Additional routes for vulnerability demonstration
  post 'login', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
  get 'dashboard', to: 'dashboard#index'
  
  # Dangerous path for SSRF
  post 'proxy', to: 'proxy#fetch'
  
  root 'articles#index'
end