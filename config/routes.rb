Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root "tweets#index"

  resources :users, only: [:show, :edit, :update]

  namespace :admin do
    root "admin/tweets#index"
  end
  # 請依照專案指定規格來設定路由

end
