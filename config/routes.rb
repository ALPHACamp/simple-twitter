Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由

  namespace :admin do
    resources :tweets
    root "tweets#index"
    # 這裡少了user路由，但先不看這裡，照原本方式就好。
  end

  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create]
    member do
      post :like 
      post :unlike
    end
  end
  root "tweets#index"

  resources :users, only: [:show, :edit, :update]
  # 多了show，看要怎麼改，增加tweet.likes.followings.followers

  resources :followships, only: [:create, :destroy]

  

  



# 大航道參考路由
  # namespace :admin do
  #   resources :tweets, only: [:index, :destroy]
  #   resources :users, only: [:index]
  #   root "tweets#index"
  # end

  # resources :tweets, only: [:index, :create] do
  #   resources :replies, only: [:index, :create]
  #   member do
  #     post :like
  #     post :unlike
  #   end
  # end
  # root "tweets#index"

  # resources :users, only: [:edit, :update] do
  #   member do
  #     get :tweets
  #     get :likes
  #     get :followings
  #     get :followers
  #   end
  # end
  # resources :followships, only: [:create, :destroy]

end
