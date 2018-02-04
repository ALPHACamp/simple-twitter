Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root "tweets#index"

  resources :users, only: [:edit, :update] do

    member do
      get :tweets
      get :likes
    end

  end

  resources :tweets, only: :create do

    member do
      post :like
      post :unlike
    end

  end

  namespace :admin do
    root "tweets#index"

    resources :tweets, only: :destroy

    resources :users, only: :index
  end

end
