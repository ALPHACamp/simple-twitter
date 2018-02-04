Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root "tweets#index"

  resources :users, only: [:edit, :update] do

    member do
      get :tweets
      get :likes
      get :followings
      get :followers
      get :likes
    end

  end

  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create]

    member do
      post :like
      post :unlike
    end

  end

  resources :followships, only: [:create, :destroy]

  namespace :admin do
    root "tweets#index"

    resources :tweets, only: [:index, :destroy]

    resources :users, only: :index
  end

end
