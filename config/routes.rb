Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  # 前台
  root "tweets#index"
  # # 推播
  resources :tweets, only: [:index, :show] do
    resources :tweets, only: [:create, :destroy]
  end
  
  # # 個人資訊
  #resources :users, only: [:index, :show, :edit, :update]

  # # 追蹤達人
  # resources :followships, only: [:create, :destroy]

  # 後台
  namespace :admin do
    resources :tweets
    resources :users
    root "tweets#index"
  end  
end
