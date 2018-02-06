Rails.application.routes.draw do
  devise_for :users
  root "tweets#index"
  
  namespace :admin do
    root "tweets#index"
    resources :tweets, only: [:index, :show, :destroy]
  end

end
