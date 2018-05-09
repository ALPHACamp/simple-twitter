Rails.application.routes.draw do
  devise_for :users

  root "tweets#index"

  namespace :admin do 
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]
    root "tweets#index"
  end

  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create]
    member do
      post :like
      post :unlike
    end
  end

  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create]
    member do
      post :like
      post :unlike
    end
  end

  resources :users, only: [:edit, :update] do 
    member do 
      get :tweets
      get :followings
      get :followers
      get :likes
    end
  end

  resources :followships, only: [:create, :destroy]
end