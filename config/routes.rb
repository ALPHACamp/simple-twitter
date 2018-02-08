Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由

  # =======前台=======
  root "tweets#index"
  resources :users, only: [:edit, :update] do
    member do
      get :tweets
    end
  end
  resources :tweets, only: [:new, :create]

  # =======後台=======
  namespace :admin do
    root "tweets#index"
  end

end
