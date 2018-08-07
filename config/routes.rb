Rails.application.routes.draw do
	root "tweets#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  
  resources :tweets, only: [:index, :create] do
    resources :replies, only:[:index, :create]
  	member do
      post :like
      post :unlike
    end
  end
  resources :users, only: [:edit, :update]  do
    member do
      get :followings
      get :followers
      get :tweets
      get :likes
    end
  end
  resources :followships, only: [:create, :destroy]
  namespace :admin do
  	resources :tweets, only: [:index ,:destroy] do
      resources :replies,only:[:index,:destroy]
    end
  	resources :users, only: :index
    root "tweets#index"
  end

  # 請依照專案指定規格來設定路由

end
