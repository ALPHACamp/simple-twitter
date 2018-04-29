Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    member do
      get :tweets
      get :followings
    end
  end

  resources :tweets, only: [:index, :create, :show, :edit, :update]

  resources :followships, only: [:create, :destroy]

  root "tweets#index"

  namespace :admin do
    root "tweets#index"
  end

end
