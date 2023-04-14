Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :regions, only: [:index, :show], defaults: { format: :json } do
        resources :provinces, only: [:index, :show], defaults: { format: :json } do
          resources :cities, only: [:index, :show], defaults: { format: :json }
        end
      end
      resources :provinces, only: [:index, :show], defaults: { format: :json } do
        resources :cities, only: [:index, :show], defaults: { format: :json }
      end
      resources :cities, only: [:index, :show], defaults: { format: :json }
    end
  end

  root 'welcome#index'

  resources :posts do
    resources :comments, except: :show
  end

  resources :comments
  resources :categories
end
