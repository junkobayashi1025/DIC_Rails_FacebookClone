Rails.application.routes.draw do
  root 'home#index'
  resources :comments, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :blogs do
    collection do
      post :confirm
    end
  end
end
