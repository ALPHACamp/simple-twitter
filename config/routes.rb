Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  resources :tweets, only: [:index, :create]
  root "tweets#index"
  resources :users, only: [:edit]

  namespace :admin do
    resources :users, only: [:index]
    resources :tweets, only: [:index, :destroy]
    root "tweets#index"
  end
end
