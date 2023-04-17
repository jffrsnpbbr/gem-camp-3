Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  constraints(ClientDomainConstraint.new) do
    resources :posts do
      resources :comments, except: :show
    end
  end


  resources :comments
  resources :categories

  constraints(AdminDomainConstraint.new) do 
    namespace :admin do
      resources :users, only: :index
    end
  end
end
