[![Maintainability](https://api.codeclimate.com/v1/badges/c0609ce113878eab620c/maintainability)](https://codeclimate.com/github/ALPHACamp/simple-twitter-workspace/maintainability)

# README

## Fork
請 Fork 到你的 GitHub 目錄下，再從自己的目錄 `git clone`。

## How to initialize

下載要用到的套件
```
$ bundle install
```
載入預設提供的資料表
```
$ rails db:migrate
```

## 自動化測試

和自動化測試有關的程式碼，都存放在 **/spec** 的專案目錄下，所有的 Model 和 Controller 文件都會有一個對應的 spec 檔案，使用 `rails generate model` 或 `rails generate controller` 指令時會自動覆寫到現有的 spec 檔案。

因此，請你不要使用 `rails generate model` 或 `rails generate controller` 指令。

相對的，在你下載的專案中，已經準備好對應的 Model 和 Controller 檔案。

如果想在本地執行自動化測試，可以輸入指令
```
$ bundle exec rspec
```
