Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由

     root "tweets#index"



      resources :tweets, only: [:index, :create, :show, :edit, :update, :destroy] do
        resources :replies, only: [:create, :edit, :update, :destroy]
        member do
          post :like
          post :unlike
        end
      end

      resources :users, only: [:index, :show, :edit, :update, :destroy] do
        member do
          get 'tweets'
          get 'likes'
          get 'replies'

          get 'followings'
          get 'followers'
        end
      end

      resources :followships, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
      resources :replies, only: [:create, :edit, :destroy]






     namespace :admin do
       resources :tweets, only: [:index, :destroy]
       resources :users
       root "tweets#index"
     end

end
