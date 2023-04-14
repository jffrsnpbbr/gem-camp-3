Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :regions, only: [:index, :show], defaults: { format: :json }
    end
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'

  resources :posts do
    resources :comments, except: :show
  end

  resources :comments
  resources :categories
end
