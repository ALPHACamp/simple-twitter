Rails.application.routes.draw do
	root "tweets#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  
  resources :tweets do
  	# 瀏覽所有推特最新動態
    collection do
      get :feeds
    end
  	member do
  		get :dashboard
      # 瀏覽個別餐廳 Dashboard,帶入餐廳id
      post :like
      post :unlike
    end
  end
  resources :users, only: [:index ,:show, :edit, :update]
  namespace :admin do
  	resources :tweets
    root "tweets#index"
  end

  # 請依照專案指定規格來設定路由

end
