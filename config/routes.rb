Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 設置tweets index作為網站首頁
  resources :tweets, only: [:index,:create]
  root 'tweets#index'

  # user頁面
  resources :users, only: [:edit, :update]

end
