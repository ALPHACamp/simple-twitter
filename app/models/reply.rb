class Reply < ApplicationRecord

  belongs_to :tweet, counter_cache: true, optional: true
  belongs_to :user, optional: true

end
