class Like < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :tweet, optional: true
end
