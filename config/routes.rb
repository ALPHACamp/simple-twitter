Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由

  # Tweet
  resources :tweets, only: [:index, :create]
  get "/" => redirect("/tweets") # 轉址
  root "tweets#index"


  # User
  
  get '/users/:id/tweets' => 'users#tweets', :as => "tweets_user" # users_tweets user 要加 s => 規格 tweets_user

  resources :users, only: [:edit, :update]
  # get '/users/:id/edit' => 'users#edit', :as => "edit_user" #  prefix edit_users 不符規格改為 edit_user
  # match '/users/:id/update', to:'users#update', via: [:patch]


  # Reply
  get '/tweets/:tweet_id/replies' => 'replies#index', :as => "tweet_replies" # prefix replies_user 不符規格改為　tweet_replies
  post '/tweets/:tweet_id/replies' => 'replies#create', :as => "replies"
  # create action path_helper 慣例用複數，規則可用 resources 先跑一遍，中間的 id 還是錯的，待處理

  # Following
  get '/users/:id/followings' => 'users#followings', :as => "followings_user" # prefix following_user 不符規格改為 followings_user
  get '/users/:id/followers' => 'users#followers', :as => "followers_user"     # prefix user_follower 不符規格改為 followers_user
  resources :followships, only: [:create, :destroy]

  # Like
  get '/users/:id/likes' => 'users#likes', :as => "likes_user"    # prefix user_likes 不符規格改為 likes_user
  post '/tweets/:id/like' => 'tweets#like', :as => "like_tweet"
  post '/tweets/:id/unlike' => 'tweets#unlike', :as => "unlike_tweet"

  # Back-End
  namespace :admin do
    resources :users, only: [:index]

    resources :tweets, only: [:index, :destroy]
    # get "/" => redirect("admin/tweets")　＃ http status 變 301 移除
    root "tweets#index"
  end
end
