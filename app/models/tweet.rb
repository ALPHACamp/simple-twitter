class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140, :message => "超過字數限制"


  # find_user method 用於tweets頁面 取得@user資料，avatar
  def find_user
    user_id = self.user_id
    @user = User.find(user_id)
  end

end
