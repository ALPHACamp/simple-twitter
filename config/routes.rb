Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  root "tweets#index"

  resources :followships, only: [:create, :destroy]

  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create]

    member do
      post :like
      post :unlike
    end

  end


  resources :users, only: [:create, :show, :update, :edit] do
    member do
      get :tweets
    end

    member do
      get :followings
    end

    member do
      get :followers
    end

    member do
      get :likes
    end

  end

  namespace :admin do
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]
    root "tweets#index"
  end


end
