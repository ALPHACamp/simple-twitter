Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :tweets, only: [:index, :create] do
  member do
      resources :replies, only: [:index, :create]
        post :like
        post :unlike
  end
    end
  resources :users, only: [:edit] do
      member do
        get :tweets
        get :followings
        get :followers
        get :likes
      end
        end
  resources :followships, only: [:create, :destroy]

  namespace :admin do
  resources :tweets, only: [:index,:destroy]
  resources :users, only: [:index]
  root "tweets#index"
end
  root "tweets#index"
  # 請依照專案指定規格來設定路由

end
