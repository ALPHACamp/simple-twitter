Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:create, :destroy]
    member do
      get :likes

    end
  end

  resources :users, only: [:edit, :update] do
    member do
      get :tweets
      get :followings
      get :followers
      get :likes
    end
  end

  resources :followships, only: [:create, :destroy]

  root "tweets#index"
  get "/users/", :to => "tweets#index"

  namespace :admin do
    resources :tweets
    resources :users
    root "tweets#index"
  end

end
