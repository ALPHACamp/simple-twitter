Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  # 前台

  # # 推播
  resources :tweets, only: [:index, :show, :create] do
    # 回覆推播
    resources :replies, only: [:create, :index]
  end
  
  # # 個人資訊
  resources :users, only: [:index, :edit, :update] do
    get :tweets, :on => :member

  end
  root "tweets#index"


  # 後台
  namespace :admin do
    resources :tweets
    resources :users
    root "tweets#index"
  end  
end
