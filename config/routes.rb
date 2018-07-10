Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  resources :tweets, only: [:index, :create] do
    # tweets#index
    # tweets#create

    member do
      post :like   # tweets#like
      post :unlike # tweets#unlike
    end

    resources :replies, only: [:index, :create]
    # replies#index
    # replies#create
    
  end

  resources :users, only: [:edit, :update] do
    member do
      get :tweets     # users#tweets
      get :followings # users#followings
      get :followers  # users#followers
      get :likes      # users#likes
    end
  end

  resources :followships, only: [:create, :destroy]
  # followships#create
  # followships#destroy

  root "tweets#index"

  namespace :admin do
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]

    root "tweets#index"
  end
end
