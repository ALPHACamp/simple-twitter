Rails.application.routes.draw do
  # 這是使用 Devise 建立 User model 產生出來的，會產生使用者認證程序中，每個頁面需要的路由
  devise_for :users

  # 請依照專案指定規格來設定路由
  # 設定前台首頁路由
    root "tweets#index"

  # 設定前台路由，首頁及新增
  # 設定在特定的推播下，可看見推播及新增(回覆)
  	resources :tweets, only: [:index, :create] do
      resources :replies, only: [:index, :create]
      member do
        post :like
        post :unlike
      end  
    end
 
  # 設定點擊使用者名字時，可以看見推播牆及編輯自己的資料路由
    resources :users, only: [:edit, :update] do
      member do
        get :tweets
        get :likes # 可看該使用者 like 的推播清單
      end
    end    

  # 設定後台首頁路由 & 設定在admin之下可看所有使用者清單
  	namespace :admin do
  		resources :tweets, only: [:index, :destroy]
      resources :users, only: [:index]
  		root "tweets#index"
  	end	

end
