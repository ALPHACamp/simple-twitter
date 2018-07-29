Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  # 前台首頁 for public users
  root "tweets#index"

  namespace :admin do
    resources :tweets
    # 後台首頁 for admin user
    root "tweets#index"
  end

  resources :users, only: [:index, :show, :edit, :update]
end
