Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  resources :tweets, only: [:index, :create] do
    member do 
      get :replies
      post :like
      post :unlike
    end 

  end

  root "tweets#index"

  resources :followships, only: [:create, :destroy]

  namespace :admin do
    resources :tweets, only: [:index, :destroy]  #index看見站內所有推播、destroy刪除其他使用者的推文 
    resources :users, only: [:index] # user#index 看見站內所有使用者
  end 



end
