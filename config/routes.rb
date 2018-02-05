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

  resources :users, only: [:edit, :show] do
    member do
      # get :followings
      # get :followers
      # get :like
      # get :unlike
      # get :tweets
    end
  end
end
