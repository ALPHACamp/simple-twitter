Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :tweets, only: [:index, :create] do
    member do
      post :like
      post :unlike
    end
  end
  root 'tweets#index'
  # 請依照專案指定規格來設定路由
  resources :user, only: [:edit] do

    member do
      get :tweets
    end
  end

  namespace :admin do
    resources :tweets, only: [:index, :destroy]
    root "tweets#index"
  end
end
