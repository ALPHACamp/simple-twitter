Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :tweets, only: [:index, :show, :create, :destroy] do
    resources :replies, only: [:create, :destroy]
    
  end


  root "tweets#index"

  resources :users, only: [:index, :show, :edit, :update]

  namespace :admin do
    resources :tweets
    root "tweets#index"
  end
  # 請依照專案指定規格來設定路由

  resources :followships, only: [:create, :destroy]

end
