Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
    resources :users, :only => [:index, :show, :edit, :update]  do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
      member do
        get :tweets
        get :followings
        get :followers
        get :likes
      end
  end
  # 請依照專案指定規格來設定路由

  resources :tweets, :only => [:index, :create] do
    member do
      post :like
      post :unlike   
      get  'replies'   => 'replies#index'
      #get  'replies'
      post 'replies'     => 'replies#create'
    end
  end
  root "tweets#index"

  resources :followships, only: [:create, :destroy]
  resources :replies, only: [:index, :create]

  namespace :admin do
    resources :users, :only => [:index]  
    resources :tweets, :only => [:index, :destroy]  
    root "tweets#index"
  end



end
