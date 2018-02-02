Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root "tweets#index"

  namespace :admin do
    root "admin/tweets#index"
  end
  # 請依照專案指定規格來設定路由

end
