Rails.application.routes.draw do
  devise_for :users
  root "tweets#index"
  resources :tweets, only: [:index]
  resources :users, only: [:edit, :update] do
    member do
      get :tweets
    end
  end

  namespace :admin do
    root "tweets#index"
    resources :tweets, only: [:index, :show, :destroy]
    resources :users, only: [:index]
  end

end
