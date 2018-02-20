Rails.application.routes.draw do
  # 這是使用 Devise 建立 User model 產生出來的，會產生使用者認證程序中，每個頁面需要的路由
  devise_for :users

  # 請依照專案指定規格來設定路由
  # 設定前台首頁路由
    root "tweets#index"

  # 設定前台路由 / 設定回覆路由
  	resources :tweets, only: [:index, :create] do
      resources :replies, only: [:index, :create]
    end
 
  # 設定 user 的相關路由
    resources :users, only: [:edit, :update] do
      member do
        get :tweets
      end
    end    

  # 設定後台首頁路由
  	namespace :admin do
  		resources :tweets, only: [:index, :destroy]
  		root "tweets#index"
  	end	

end
