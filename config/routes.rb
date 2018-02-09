Rails.application.routes.draw do
  devise_for :users
  root "tweets#index"
  resources :tweets, only: [:index, :create] 
  resources :followships, only: [:create, :destroy]

  resources :users, only: [:edit, :update] do
    member do
      get :tweets
      get :followings
      get :followers
    end
  end

  namespace :admin do
    root "tweets#index"
    resources :tweets, only: [:index, :show, :destroy]
    resources :users, only: [:index]
  end

end
