Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  resources :tweets, only: [:index, :create] 

  resources :tweets, only: [:show] do
    resources :replies, only:[:index, :create]
  end


  resources :users, only: [:edit]
  
  
  
  get '/users/:id/tweets' => 'users#tweets', :as => "users_tweets"

  root "tweets#index"

  namespace :admin do 
    resources :tweets, only:[:index, :destroy]
    resources :users, only:[:index]
  end
end
