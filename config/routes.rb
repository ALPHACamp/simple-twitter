Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root "tweets#index"
  # 請依照專案指定規格來設定路由
  resources :followships, only: [:create, :destroy]
  resources :users, only: [:edit] do
    member do
      get :tweets
    end
  end
  resources :tweets, only: [:index, :create] do
    member do
      post :like
      post :unlike
    end
  end
end
