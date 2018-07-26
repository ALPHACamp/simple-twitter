Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root "tweets#index"

  resources :tweets, only: [:index,:create]
  resources :replies, only: [:index,:create]
    root "tweet#index"
  resources :followships, only: [:create,:destroy]

  namespace :admin do
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]
    root "tweets#index"
  end



  # 請依照專案指定規格來設定路由

end
