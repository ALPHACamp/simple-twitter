class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }

  #counter_cache 指南 https://rails.ruby.tw/association_basics.html
  belongs_to :user, counter_cache: :followers_count
  belongs_to :following, class_name: "User"
end
