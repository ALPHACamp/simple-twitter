Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  root "tweets#index"
  resources :tweets, only: [:create] do
    member do
      post :like
      delete :unlike
    end
  end

  resources :tweets, only: [:show] do
    resources :replies, only: [:index, :create]
  end


  namespace :admin do
    root "tweets#index"
    resources :tweets, only: [:destroy]
    resources :users, only: [:index]
  end

  resources :users, only: [:edit, :update]

  resources :users, only: [:show] do
    member do
      get :tweets
      get :followings
      get :followers
      get :likes
    end
  end

  resources :followships, only: [:create, :destroy]

end
