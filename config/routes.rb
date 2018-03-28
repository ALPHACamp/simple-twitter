Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由

  # Tweet
  resources :tweets, only: [:index, :create]
  get "/" => redirect("/tweets") # 轉址
  root "tweets#index"


  # User
  # resources :users, only: [:edit]
  get '/users/:id/tweets' => 'users#tweets', :as => "users_tweets" # helper user 要加 s
  get '/users/:id/edit' => 'users#edit', :as => "edit_users"
  match '/users/:id/update', to:'users#update', via: [:patch]


  # Reply
  get '/tweets/:tweet_id/replies' => 'replies#index', :as => "replies_user"
  post '/tweets/:tweet_id/replies' => 'replies#create', :as => "replies"
  # create action path_helper 慣例用複數，規則可用 resources 先跑一遍，中間的 id 還是錯的，待處理

  # Following
  get '/users/:id/followings' => 'users#followings', :as => "following_user"
  get '/users/:id/followers' => 'users#followers', :as => "user_follower"
  resources :followships, only: [:create, :destroy]

  # Like
  get '/users/:id/likes' => 'users#likes', :as => "user_likes"
  post '/tweets/:id/like' => 'tweets#like', :as => "like_tweet"
  post '/tweets/:id/unlike' => 'tweets#unlike', :as => "unlike_tweet"

  # Back-End
  namespace :admin do
    resources :users, only: [:index]

    get '/tweets' => 'tweets#index', :as => "tweets"
    resources :tweets, only: [:destroy]
  end
end
