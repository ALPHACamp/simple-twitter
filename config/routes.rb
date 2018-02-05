Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  # 請依照專案指定規格來設定路由
  resources :users, only: [:index, :show, :edit, :update] do
  end  

  resources :tweets, only: [:index, :create, :show] do
    
  end
  

  root "tweets#index"     # 前台入口

  namespace :admin  do    
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index] # 管理者可以瀏覽站內所有的使用者清單
    root "tweets#index"   # 後台入口
  end  
end
