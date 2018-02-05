Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  namespace :admin do
    resources :tweets, only: [:index, :create]
    root "tweets#index"
  end

  resources :tweets, only: [:index, :destroy] do
    resources :replies, only: [:index, :create]
    member do
        post :favorite
        post :unfavorite
      end
  end
  root "tweets#index"

  resources :users, only: [:edit, :update] do
    member do
      get :tweets
      get :likes
    end
  end

end


