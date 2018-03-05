class Admin::BaseController < ApplicationController
  # 加入認證程序，使用者需登入才能瀏覽網站
  before_action :authenticate_user!
end
