Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :tweets, only: [:index, :create]
  # 請依照專案指定規格來設定路由

  root "tweets#index"

  namespace :admin do 
    resources :tweets, only: [:index, :destroy]
    resources :users
    root "tweets#index"
  end

end
