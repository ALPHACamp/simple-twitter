Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tweets, only: [:index, :create ] do
    resources :replies, only: [:index, :create]

    member do
      post :like
      post :unlike
    end
    
  end

  

  root "tweets#index"

  resources :users, only: [:edit] do

    member do
      get :tweets
      get :followings
      get :followers
      get :likes
    end

  end

  resources :followships, only: [:create, :destroy]

  namespace :admin do 
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]
    root "tweets#index"
  end
end
