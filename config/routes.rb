Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  root "tweets#index" #dafault page

  resources :tweets, only: [:index,:create]

  resources :users do
     member do
      get :tweets
    end
  end

  namespace :admin do
    root "tweets#index" 
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]
  end
end
