Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  resources :tweets, only: [:index] do
    resources :replies, only: [:create]
  end
  resources :users, only: [:edit, :update]
  
  # 前台首頁：看見站內所有的推播，以及跟隨者最多的使用者
  root 'tweets#index'
  
  # 後台首頁：管理者登入網站後，能夠進入後台頁面
  namespace :admin do
    root "tweets#index"
    resources :tweets, only: [:index, :destroy]
  end


end
