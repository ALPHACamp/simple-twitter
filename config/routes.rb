Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由

     root "tweets#index"

     authenticated :user do
        root to: "tweets#index"
      end
      unauthenticated :user do
        root 'static_pages#index'
      end

      resources :tweets, except: [:new, :edit] do
        member do
          post :reply
        end
      end
      resources :users, except: [:new, :create] do
        member do
          get 'followers'
          get 'followings'
          get 'likes'
          get 'replies'
        end
      end

      resources :followships, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
      resources :replies, only: [:create, :destroy]
      # resources :find_friends, only: :index





     namespace :admin do
       resources :tweets
       resources :users
       root "tweets#index"
  end

end
