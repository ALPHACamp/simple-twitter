Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :followships, only: [:create, :destroy]
  resources :users, only: [:index, :edit, :update] do
    member do
      get :tweets
      get :followings
      get :followers
      get :likes
    end
  end
  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create]
      member do
        get :like
        get :unlike
      end
  end

  root"tweets#index"

  namespace :admin do
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]

    root "tweets#index"
  end


  # 請依照專案指定規格來設定路由

end
