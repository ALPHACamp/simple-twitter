Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users, only: [:edit, :update] do

  end

  # 請依照專案指定規格來設定路由
  resources :tweets, only: [:index, :create] do

    member do
      # reply page
      get :replies
      post :replies

      # like button
      post :like
      post :unlike
    end

  end
  root "tweets#index"

  namespace :admin do
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]
  end

end
