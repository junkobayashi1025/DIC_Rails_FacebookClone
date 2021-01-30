Rails.application.routes.draw do
  root 'sessions#new'
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :comments, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
end
