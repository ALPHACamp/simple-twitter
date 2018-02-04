class Reply < ApplicationRecord
  belongs_to :tweet ,optional: :ture
  belongs_to :user, optional: :ture


  def count_replies(tweet) 
    @tweet.replies.count
  end
end
