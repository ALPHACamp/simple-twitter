Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  # 請依照專案指定規格來設定路由
  resources :users, only: [:index, :edit, :update] do
    member do
      get :tweets
      get :followings
      get :followers
      get :likes
    end  
  end  

  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create] #使用者能回覆別人的推播    

    member do
      post :like
      post :unlike
    end  
  end
  
  # user可 建立/刪除 追蹤其他user
  resources :followships, only: [:create, :destroy]

  root "tweets#index"     # 前台入口

  namespace :admin  do    
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index] # 管理者可以瀏覽站內所有的使用者清單
    root "tweets#index"   # 後台入口
  end  
end
