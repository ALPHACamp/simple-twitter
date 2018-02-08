Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  get "/", :to => "tweets#index"
  resources :tweets, only: [:index, :show, :create] do
  	member do
  		get :replies ,:to => "replies#index"
  		post :replies ,:to => "replies#create"
  		post :like
  		post :unlike
  	end
  end

  resources :users, only: [] do
  	member do
  		get :tweets
  		get :followings
  		get :followers
      get :likes
  	end
  end

  resources :followships, only: [:create, :destroy]

  namespace :admin do
  	get "/", :to => "tweets#index"
  	resources :tweets, only: [:index, :destroy, :show] do
      member do
        post :delete_reply
      end
    end
  	resources :users, only: [:index, :destroy]
  end

end
