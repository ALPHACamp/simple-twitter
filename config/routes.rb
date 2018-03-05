Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # 請依照專案指定規格來設定路由
  # 前台路由

  # GET /tweets 看見站內所有的推播，以及跟隨者最多的使用者
  # POST /tweets 將新增的推播寫入資料庫
  resources :tweets, only: [:index, :create] do
    member do
      # 新增一筆 like 記錄
      post :like
      # 刪除一筆 like 記錄
      post :unlike
    end

    # /tweets/:id 與 /tweets/:tweet_id 不知有無差異，:tweet_id 應爲其他資料表的外鍵
    # GET /tweets/:tweet_id/replies 可以在這頁回覆特定 tweet，並看見 tweet 主人的簡介
    # POST /tweets/:tweet_id/replies 將回覆內容寫入資料庫
    # ...原來這時候不用 namespace 也不用 member，或是 resources path: "/:tweet_id/reply" 指定 路徑，會自動依賴 rails 慣例，將路徑 :id 改爲 :tweet_id？
    resources :replies,  only: [:index, :create]
  end

  # 設定 / 前台首頁 
  root "tweets#index"

  # 使用者編輯自己的介紹
  resources :users, only: [:edit] do
    member do
      # 看見某一個使用者的推播牆，以及該使用者簡介
      get :tweets
      # 看見某一個使用者正在關注的使用者
      get :followings
      # 看見某一使用者的追隨者
      get :followers
      # 看見某一個使用者按過 like 的推播
      get :likes
    end
  end

  # 新增一筆 followship 記錄
  # 刪除一筆 followship 記錄
  resources :followships, only: [:create, :destroy]

  # 後台路由
  namespace :admin do
    # GET /admin/tweets 看見站內所有的推播 (後台首頁)
    # DELETE /admin/tweets/:id 刪除其他使用者的推文
    resources :tweets, only: [:index, :destroy]
    # 看見站內所有的使用者
    resources :users, only: [:index]

    # 設定 /admin 後台首頁
    root "tweets#index"
  end
end
