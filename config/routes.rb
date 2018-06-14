Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  root "tweets#index" #前台首頁

  resources :followships, only: [:create, :destroy]

  resources :tweets do
    resources :replies, only: [:index, :create] #使用者在個別推播下留下回覆

    member do
      post :like
      post :unlike
    end

  end


  resources :users, only: [:show, :edit, :update] do
    get :tweets
    get :followings
    get :followers
  end
  

  namespace :admin do
    root "tweets#index" #後台首頁
  end

end
