Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  root "tweets#index"
  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create]
  end

  resources :users, only: [:edit, :update] do
    member do
      get :tweets
    end

    resources :followships, only: [:create, :destroy]
  end


  namespace :admin do
    resources :tweets, only: :destroy do

      collection do
        get :allusers
      end
    end
    root "tweets#index"

    resources :users, only: :index

  end
end
