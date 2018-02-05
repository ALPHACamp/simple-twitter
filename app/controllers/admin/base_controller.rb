class Admin::BaseController < ApplicationController
  before_action :authenticate_user! # 登入才能使用網站
end
