Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 設置tweets
  resources :tweets, only: [:index,:create] do 

    member do
      resources :replies, only: [:index, :create]
    end

  end

  # 設置user
  resources :users, only: [:edit, :update] do
    
    member do
      get :tweets
    end

  end

  # 設置tweets index作為網站首頁
  root 'tweets#index'

end
