Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  
  # 請依照專案指定規格來設定路由
  root 'tweets#index'
  resources :users, only: [:index, :show, :edit, :update]
  resources :tweets, only: [:index, :create, :like, :unlike] do
    member do
      post :like
      get :replies
      get :likes
    end
  end

  resources :replies, only: [:index, :create]
  resources :users, only: [:index, :show] do
    collection do
      # GET users/tweets

    end
    member do
      get :like
      get :tweets
            
      get :followings
      get :followers
      #post :unfavorite
    end
  end
  resources :followships, only: [:create, :destroy]
  namespace :admin do
  resources :users, only: [:index]
  resources :tweets, only: [:index, :destroy]
  root 'tweets#index'
  end
end

