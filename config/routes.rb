Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root "tweets#index"

  resources :users, only: [:show,:edit,:update] do
    member do
      get :tweets
    end
  end


  resources :tweets, only: [:create] 



  namespace :admin do
    resources :tweets
    resources :users
    root "tweets#index"
  end
  # 請依照專案指定規格來設定路由

end
