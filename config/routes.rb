Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tweets, only: [:index, :create ]

  root "tweets#index"

  namespace :admin do 
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index]
    root "tweets#index"
  end
end
