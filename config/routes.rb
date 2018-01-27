Rails.application.routes.draw do
  resources :tweets

  resources :users, only: [:edit] do
    member do
      get :tweets
    end
  end

  root 'tweets#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
