Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  resources :tweets,only: [:index,:create] do
    member do
      resources :replies,only: [:index,:create]
    end
  end
  root "tweets#index"

  get "users/:id/tweets" , to: 'users#tweets', as: 'users_tweets'
  get "users/:id/followings" , to: 'users#followings', as: 'users_followings'
  get "users/:id/followers" , to: 'users#followers', as: 'users_followers'

  resources :followships,only: [:create,:destroy]

  get "users/:id/likes" , to: 'users#likes', as: 'users_likes'

  post "tweets/:id/like" , to: 'tweets#like', as: 'tweets_like'
  post "tweets/:id/unlike" , to: 'tweets#unlike', as: 'tweets_unlike'

  get "users/:id/edit" , to: 'users#edit', as: 'edit_user'
  post "users/:id/edit" , to: 'users#update'

  namespace :admin do
    root "tweets#index"
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]
  end
end
