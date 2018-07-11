Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  namespace :admin do
    root "tweets#index"
  end
  namespace :admin do
    resources :tweets
    root "tweets#index"
  end
  resources :tweets
  root "tweets#index"
end
