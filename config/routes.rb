Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  
  # 請依照專案指定規格來設定路由
  root 'tweets#index'
  resources :users, only: [:index, :show, :edit, :update]
  resources :tweets, only: [:index, :create, :like, :unlike] do
    member do
      post :like
    end
  end

  resources :replies, only: [:index, :create]
  resources :users, only: [:index, :show] do
    collection do
      # 瀏覽所有餐廳的最新動態
      # GET users/tweets
      
      get :followings
      get :followers
    end
    member do
      get :like
      get :tweets
      #post :unfavorite
    end
  end
  resources :followships, only: [:create, :destroy]
end

