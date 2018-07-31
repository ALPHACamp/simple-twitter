class Like < ApplicationRecord

   belongs_to :user
   belongs_to :tweet, optional: true
end
