Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由

  # Tweet
  get '/tweets' => 'tweets#index', :as => "tweets"
  resources :tweets, only: [:create]

  # User
  resources :users, only: [:edit]
  get '/users/:id/tweets' => 'users#tweets', :as => "user_tweets"

  # Reply
  get '/tweets/:id/replies' => 'replies#index', :as => "replies_user"
  post '/tweets/:id/replies' => 'replies#create', :as => "reply"

  # Following
  get '/users/:id/followings' => 'users#followings', :as => "following_user"
  get '/users/:id/followers' => 'users#followers', :as => "user_follower"
  resources :followships, only: [:create, :destroy]

  # Like
  get '/users/:id/likes' => 'users#likes', :as => "user_likes"
  post '/tweets/:id/like' => 'tweets#like', :as => "tweet_like"
  post '/tweets/:id/unlike' => 'tweets#unlike', :as => "tweet_unlike"

  # Back-End
  namespace :admin do
    resources :users, only: [:index]

    get '/tweets' => 'tweets#index', :as => "tweets"
    resources :tweets, only: [:destroy]
  end
end
