class Like < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :tweet, counter_cache: true

  # 排序
  # default_scope :order => "created_at desc"
end
