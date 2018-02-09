class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  # 排序
  # default_scope :order => "created_at desc"
end
