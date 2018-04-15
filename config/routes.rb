Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 設置tweets
  resources :tweets, only: [:index,:create] do 

    resources :replies, only: [:index, :create]
    
    member do
      post :like
      post :unlike
    end

  end

  # 設置user
  resources :users, only: [:edit, :update] do
    
    member do
      get :tweets
      get :followings
      get :followers
      get :likes
    end

  end

  # 設置followship
  resources :followships, only: [:create, :destroy]

  # 設置admin
  namespace :admin do
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]
    root 'tweets#index'
  end


  # 設置tweets index作為網站首頁
  root 'tweets#index'

end
