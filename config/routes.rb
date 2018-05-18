Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # 請依照專案指定規格來設定路由
  devise_for :users
  root 'tweets#index'
  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create]
    member do
      post :like
      post :unlike
    end
  end

  resources :users, only: %i[edit update] do
    member do
      get :tweets
      get :followings
      get :followers
      get :likes
    end
  end

  resources :followships, only: [:create, :destroy]

  namespace :admin do
    resources :tweets, only: [:index,:destroy]
    root 'tweets#index'
    resources :users, only: [:index]
    
  end
end
