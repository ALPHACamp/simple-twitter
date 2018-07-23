Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  # 請依照專案指定規格來設定路由
  # 設定前台路由
  root "tweets#index"

  # 設定後台路由
  namespace :admin do
    resources :tweets
    root "tweets#index"
  end
  # 設定user路由
  resources :users, only: [:show, :edit, :update]
  
end
