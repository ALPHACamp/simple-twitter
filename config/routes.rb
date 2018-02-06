Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  root "tweets#index"
  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create]
  end

  resources :users, only: [:edit, :update] do
    #member 用於找單一user的全部tweets
    member do 
      get :tweets
      get :followings
      get :followers
    end
  end

  resources :followships, only: [:create, :destroy]

  
  # Admin
  namespace :admin do
  	resources :tweets, only: [:index, :destroy]
  	root "tweets#index"
  end
end
