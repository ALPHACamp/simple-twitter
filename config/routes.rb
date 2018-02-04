Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 設定root
  root "tweets#index"

  #tweets routes
  resources :tweets, only: [:index, :create] do

    member do 
      get :replies , :controller => 'replies', :action => 'index'
      post :replies, :controller => 'replies', :action => 'create'
      post :like
      post :unlike
    end

  end

  #users routes
  resources :users, only: [:edit, :update] do

    member do
      get :tweets
    end

  end



  #admin routes
  namespace :admin do
    root "tweets#index"
    resources :tweets, only: [:index, :destroy]     
  end


  # 請依照專案指定規格來設定路由

end
