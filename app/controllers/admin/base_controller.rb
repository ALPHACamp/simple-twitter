class Admin::BaseController < ApplicationController
  # 加入認證程序，使用者需登入才能瀏覽網站
  before_action :authenticate_user!

  # 加入使用者身份檢查，需爲管理員才能瀏覽後台
  before_action :authenticate_admin
end
