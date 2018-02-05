Rails.application.routes.draw do
  devise_for :users

  # 請依照專案指定規格來設定路由
  root 'tweets#index'
  resources :tweets
  resources :users
end
