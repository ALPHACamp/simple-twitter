Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  namespace :admin do
    resources :tweets, only: [:index, :destroy]
    root "tweets#index"
  end
  resources :tweets do
    resources :replys, only: [:create]
  end
  root "tweets#index"
end
