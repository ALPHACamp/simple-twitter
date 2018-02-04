Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  resources :users, only: [:show, :edit, :update]
  resources :tweets, only: [:index, :show, :create] do
    resources :replies, only: [:index, :create, :destroy]
    
  end



  root "tweets#index"

  namespace :admin do

    resources :users, only: [:index, :show]
    resources :tweets, only: [:index, :show, :destroy] do
      resources :replies, only: [:index, :destroy]
    end
    
    root "tweets#index"
  end

end
