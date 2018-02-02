Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  resources :tweets, only: [:index, :show, :create] do
  	member do
  		get :replies ,:to => "replies#index"
  		post :replies ,:to=> "replies#create"
  		post :like
  		post :unlike
  	end
  end

  resources :uesrs, only: [:edit] do
  	member do
  		get :tweets
  		get :followings
  		get :followers
  	end
  end

  resources :followships, only: [:create, :destroy]

  namespace :admin do
  	resources :tweets, only: [:index, :destroy]
  	resources :users, only: [:index]
  end

end
