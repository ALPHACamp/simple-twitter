Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  root "tweets#index"
  resources :tweets, only: [:index, :create]

  # user下的巢狀路由
  resources :users, only: [:edit] do
    resources :tweets, only: [:index]
  end

  # 透過 namespace 建立後台的路由
  namespace :admin do
    root "tweets#index"
  end

end
