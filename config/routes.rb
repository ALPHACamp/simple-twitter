Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  # 前台

  # # 推播
  resources :tweets, only: [:index, :show, :create] do

  end
  
  # # 個人資訊
  resources :users, only: [:index, :show, :edit, :update]
  root "tweets#index"
  # # 追蹤達人
  # resources :followships, only: [:create, :destroy]

  # 後台
  namespace :admin do
    resources :tweets
    resources :users
    root "tweets#index"
  end  
end
