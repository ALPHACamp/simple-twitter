class Admin::BaseController < ApplicationController
  before_action :authenticate_user! # 登入才能使用網站
  before_action :authenticate_admin # admin才能進入後台
end
