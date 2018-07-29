Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tweets, only: [:index, :create ]

  root "tweets#index"

  namespace :admin do 
    resources :tweets, only: [:index, :destroy]
  end
end
