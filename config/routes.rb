Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由

   root "tweets#index"


  namespace :admin do
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]
    root "admin/tweets#index"
  end

  resources :tweets, only: [:index, :show, :create] do
    resources :replies, only: [:index, :create]

    member do
      post :like
      post :unlike
    end

  end



  resources :users, only: [:index, :show, :edit, :update] do
  
    member do 
       get :likes
       get :tweets
       get :followings
       get :followers
     end

  end


  
  resources :followships, only: [:create, :destroy]


end
