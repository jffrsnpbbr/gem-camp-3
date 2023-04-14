Rails.application.routes.draw do
  devise_for :users
  
  namespace :api do
    namespace :v1 do
      resources :regions, only: [:index, :show], defaults: { format: :json } do
        resources :provinces, only: [:index, :show], defaults: { format: :json }
      end
      resources :provinces, only: [:index, :show], defaults: { format: :json }
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'

  resources :posts do
    resources :comments, except: :show
  end

  resources :comments
  resources :categories
end
