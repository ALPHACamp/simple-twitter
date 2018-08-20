Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由

  # 前台首頁 for public users
  root "tweets#index"

  namespace :admin do
    root "tweets#index"
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]
  end

  resources :users, only: [:edit, :update] do
    member do
      get :tweets
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

end
