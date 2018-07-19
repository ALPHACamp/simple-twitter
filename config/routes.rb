Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  namespace :admin do
    root "tweets#index"
    get 'users' => 'users#index'
    resources :tweets, only: [:index, :destroy]
  end

  resources :tweets do
    resources :replies
    member do
      post 'like'
      post 'unlike'
    end
  end

  resources :users do
    member do
      get 'tweets' => 'users#tweets', controller: 'users'
    end
  end
  root "tweets#index"
end
