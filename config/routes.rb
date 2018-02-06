Rails.application.routes.draw do
  devise_for :users

  # 請依照專案指定規格來設定路由
  root 'tweets#index'
  resources :tweets, only: [:index, :create, :show] do
    resources :replies, only: [:index, :create]
    member do
      post :like
      post :unlike
    end
  end
  resources :followships, only: [:create, :destroy]
  resources :users, only: [:edit, :show, :update] do
    member do
      get :tweets
      get :followings
      get :followers
      get :likes
    end
  end

  namespace :admin do
    resources :tweets, only: [:index, :destroy]
    resources :users
  end
end
