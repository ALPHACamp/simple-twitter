Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由

  root "tweets#index"     # 前台入口

  namespace :admin  do    # 後台入口
    root "tweets#index"
  end  
end
