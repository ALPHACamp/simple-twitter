Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  # 請依照專案指定規格來設定路由
  # 設定前台路由
  root "tweets#index"

  # 設定後台路由
  namespace :admin do
    resources :tweets, only: [:index, :destroy] 
    resources :users, only: [:index]
    root "tweets#index"
  end
  # 設定user路由及某user的簡介及推播
    resources :users, only: [:edit, :update] do
      member do
        get :tweets
        get :followings
        get :followers
        get :likes
      end
    end
  # 設定前台使用者行為路由
    resources :tweets, only: [:index, :create] do
      resources :replies, only: [:index, :create]

   # 設定user喜歡或取消喜歡tweet
      member do
        post :like
        post :unlike
      end
    end
  # 設定追蹤路由
    resources :followships, only: [:create, :destroy]

  end
