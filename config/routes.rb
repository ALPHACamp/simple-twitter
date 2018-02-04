Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users, only: [:update]
  resources :users, only: [:edit] do
    member do 
      get :tweets
      get :likes
    end
  end

  # 請依照專案指定規格來設定路由
  resources :tweets, only: [:index, :create] 
    

 

  resources :tweets, only: [:show] do
    resources :replies, only:[:index, :create]
    member do 
      post :like
      post :unlike
    end
  end

  

  root "tweets#index"

  namespace :admin do 
    resources :tweets, only:[:index, :destroy]
    resources :users, only:[:index]
  end
end
