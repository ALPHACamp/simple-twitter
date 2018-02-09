Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  root "tweets#index"

  resources :users, only:[:edit,:update] do
    
    member do
      get :tweets
      get :followings
      get :followers
      get :likes
    end 
  end

  resources :tweets, only:[:create, :index] do
    
    member do
      get :replies
    end

    resource :replies, only:[:create]
  end

  resources :followships, only: [:create, :destroy]



  namespace :admin do
    resources :tweets, only:[:destroy]
    resources :users, only:[:index]
    root "tweets#index"
  end


end
