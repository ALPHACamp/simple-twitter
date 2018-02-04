Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root "tweets#index"

  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create]
  end

  namespace :admin do
    resources :tweets, only: [:index, :destroy]
  end

  resources :users, only: [:edit, :update] do
    member do
      get :tweets
    end
  end

end
