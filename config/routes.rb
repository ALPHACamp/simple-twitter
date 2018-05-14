Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # 請依照專案指定規格來設定路由
  devise_for :users
  root 'tweets#index'
  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create]
    member do
      post :like
      post :unlike
    end
  end

  resources :users, only: %i[show edit update] do
    member do
      get :tweets
    end
  end

  resources :followships, only: [:create, :destroy]

  namespace :admin do
    resources :tweets
    root 'tweets#index'
  end
end
