

# Simple Twitter

# 安裝：

```
- $ git clone git@github.com:wakinglife/simple_twitter.git
- $ cd simple_twitter
- $ bundle install
- $ rails db:migrate
```
### Generate seed data and fake data
#### Seed file generate a admin role
```
- $ rails db:seed
```
#### Fake data   
-  先新增分類項目
```
- $ rails dev:fake
```
# User stories
## 使用者認證
- 除了註冊和登入頁，使用者一定要登入才能使用網站
- 使用者能創建帳號、登入、登出 
- 除了信箱和密碼，使用者在註冊時還能設定自己的名稱
- 使用者的名稱不能重覆，若有重覆會跳出錯誤 
## 後台管理介面
- 進入後台必須有管理員 (admin) 權限
- seed.rb，新增一組預設管理員，限定帳號：admin@twitter.com；密碼：87654321
- 管理者登入網站後，能夠進入後台頁面 
- 管理者可以瀏覽所有的推播與推播回覆內容
- 管理者可以刪除使用者的推播
- 管理者可以瀏覽站內所有的使用者清單, 該清單會列出他們的活躍程度（包括推播數量、關注人數、跟隨者人數、like 過的推播數）
- 管理者可以瀏覽站內所有的使用者清單，該清單按推播文數排序
## Profile
- 使用者能編輯自己的名稱、介紹和大頭照
- 使用者能瀏覽所有的推播 (tweet)
- 點擊其他使用者的名稱時，能瀏覽該使用者的個人資料及推播
- 任何登入使用者都可以瀏覽特定使用者的以下資料： 
- Tweets：排序依日期，最新的在前
- Following：該使用者的關注清單，排序依照追蹤紀錄成立的時間，愈新的在愈前面
- Follower：該使用者的跟隨者清單，排序依照追蹤紀錄成立的時間，愈新的在愈前面
- Like：該使用者 like 過的推播清單，排序依 like 紀錄成立的時間，愈新的在愈前面
## 推播
- 使用者能新增推播（限制在 140 字裡）
- 使用者能回覆別人的推播
- 使用者能對別人的推播按 Like/Unlike
## 追蹤
- 使用者能在首頁看見跟隨者 (followers) 數量排列前 10 的使用者推薦名單
- 使用者可以追蹤/取消追蹤其他使用者（不能追蹤自己）
#### https://simple-twitter-ph.herokuapp.com


