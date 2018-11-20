[![Maintainability](https://api.codeclimate.com/v1/badges/c0609ce113878eab620c/maintainability)](https://codeclimate.com/github/ALPHACamp/simple-twitter-workspace/maintainability)

# Simple Twitter

## 目錄
* [Getting Started](#getting-started)
* [User Story](#user-story)
* [自動化測試](#自動化測試)

## Getting Started
#### Install project
```
$ bundle install
$ rails db:migrate
```
#### Setup data for development
```
$ rails db:seed
$ rails dev:fake_user
$ rails dev:fake_tweet
```
#### Setup environment
本專案將圖片存在雲端服務Cloudinary，須將相關設定存入`config/cloudinary.yml`，
大寫字母為需要修改的內容
```
development:
  cloud_name: "CLOUD_NAME"
  api_key: "API_KEY"
  api_secret: "API_SECRET"
  secure: true
  cdn_subdomain: true

production:
  cloud_name: "CLOUD_NAME"
  api_key: "API_KEY"
  api_secret: "API_SECRET"
  secure: true
  cdn_subdomain: true
```
## User Story
* 除了註冊和登入頁，使用者一定要登入才能使用網站
* 使用者能創建帳號、登入、登出
  * 除了信箱和密碼，使用者在註冊時還能設定自己的名稱
  * 使用者的名稱不能重覆，若有重覆會跳出錯誤
  * 使用者能編輯自己的名稱、介紹和大頭照
* 使用者能瀏覽所有的推播 (tweet)
* 使用者能在首頁看見跟隨者 (followers) 數量排列前 10 的使用者推薦名單
* 點擊其他使用者的名稱時，能瀏覽該使用者的個人資料及推播
* 使用者能新增推播（限制在 140 字裡）
* 使用者能回覆別人的推播
* 使用者可以追蹤/取消追蹤其他使用者（不能追蹤自己）
* 使用者能對別人的推播按 Like/Unlike
* 任何登入使用者都可以瀏覽特定使用者的以下資料：
  * Tweets：排序依日期，最新的在前
  * Following：該使用者的關注清單，排序依照追蹤紀錄成立的時間，愈新的在愈前面
  * Follower：該使用者的跟隨者清單，排序依照追蹤紀錄成立的時間，愈新的在愈前面
  * Like：該使用者 like 過的推播清單，排序依 like 紀錄成立的時間，愈新的在愈前面
* 管理者登入網站後，能夠進入後台頁面
  * 管理者可以瀏覽所有的推播與推播回覆內容
  * 管理者可以刪除使用者的推播
  * 管理者可以瀏覽站內所有的使用者清單
    * 該清單會列出他們的活躍程度（包括推播數量、關注人數、跟隨者人數、like 過的推播數）
    * 管理者可以瀏覽站內所有的使用者清單，該清單按推播文數排序

## 自動化測試
Created by [ALPHACamp](https://github.com/ALPHACamp)

和自動化測試有關的程式碼，都存放在 **/spec** 的專案目錄下，所有的 Model 和 Controller 文件都會有一個對應的 spec 檔案，使用 `rails generate model` 或 `rails generate controller` 指令時會自動覆寫到現有的 spec 檔案。

因此，請你不要使用 `rails generate model` 或 `rails generate controller` 指令。

相對的，在你下載的專案中，已經準備好對應的 Model 和 Controller 檔案。

如果想在本地執行自動化測試，可以輸入指令
```
$ bundle exec rspec
```
