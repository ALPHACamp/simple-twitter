Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #devise_for :users #original route for devise
  devise_for :users, :controllers => { :registrations => "users/registrations" }#20180321-01 add for devise because of strong parameter

  # 請依照專案指定規格來設定路由
  resources :users, only: [:edit, :update]

  resources :tweets, only: [:index]




  root "tweets#index"

end
