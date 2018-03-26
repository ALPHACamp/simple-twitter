Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create]
    member do
      get :like
      post :unlike
    end
  end

  root "tweets#index"

  resources :users, only: [:edit] do
    member do
      get :likes
      get :tweets
      get :followings
      get :followers
    end
  end

  resources :followships, only: [:create, :destroy]

  namespace :admin do
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]
    root "tweets#index"
  end
end
