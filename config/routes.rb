Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users, only: [:edit, :update]
  resources :tweets, only: [:index, :create] do
    resources :replies
  end

  root"tweets#index"

  namespace :admin do
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]
    root "tweets#index"
  end


  # 請依照專案指定規格來設定路由

end
