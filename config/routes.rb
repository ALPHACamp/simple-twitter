Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

 # 請依照專案指定規格來設定路由
  resources :tweets, only: [:index, :create]
  root "tweets#index"

  resources :users, only: [:edit, :update]

  resources :tweets, only: [:index, :show, :create]

  namespace :admin do
    resources :tweets
    root "tweets#index"
  end 
end
