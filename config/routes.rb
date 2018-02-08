Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  namespace :admin do
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]
    root "tweets#index"
  end 

  resources :tweets, only: [:index, :create] do
    member do
      post :like
      post :unlike
      resources :replies, only: [:index, :create]
    end
  end

  resources :users do
    member do
      get :tweets
      get :followers
      get :followings
      get :likes
    end
  end

  resources :followships, only: [:create, :destroy]

  root "tweets#index"
end
