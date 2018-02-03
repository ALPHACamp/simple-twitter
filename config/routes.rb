Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  
  resources :tweets, only: [:index,:create] do
    resources :replies, only: [:index, :create]

    post :like, :on => :member
    post :unlike, :on => :member
  end

  resources :users, only: [:edit] do
    get :tweets, :on => :member
    get :followings, :on => :member
    get :followers, :on => :member
    get :likes, :on => :member
  end

  resources :followships, only: [:create,:destroy]

  namespace :admin do
    resources :tweets , only: [:index, :destroy]
    resources :users , only: [:index]
  end

end
