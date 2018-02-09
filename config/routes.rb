Rails.application.routes.draw do
  devise_for :users

  root "tweets#index"

  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create]
    member do
      post :like
      post :unlike
    end
  end

end