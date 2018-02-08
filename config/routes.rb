Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root "tweets#index"
  resources :tweets
  resources :users, only: [:edit, :update]
  resources :followships, only: [:create, :destroy]

  resources :users ,only: [:show] do
    member do
      get :tweets
      get :likes
      get :followings
      get :followers
    end
   
  end

  resources :tweets do

    member do
      post :like
      post :unlike
    end

    resources :replies,only: [:index, :create]
   
  end
  

  namespace :admin do
    root "tweets#index"
    resources :tweets
    resources :users, only: [:index]
  end

  # 請依照專案指定規格來設定路由

end
