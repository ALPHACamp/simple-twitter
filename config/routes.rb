Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  root "tweets#index" #前台首頁

  resources :followships, only: [:create, :destroy]

  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create] #使用者在個別推播下留下回覆

    member do
      post :like
      post :unlike
    end

  end


  resources :users, only: [:show, :edit, :update] do
    member do
      get :tweets
      get :followings
      get :followers
      get :likes
    end
  end
  


  #管理者後台
  namespace :admin do
    resources :tweets do
      resources :replies
    end

    resources :users, only: [:index]

    root "tweets#index" #後台首頁
  end

end
