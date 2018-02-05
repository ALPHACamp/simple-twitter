class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  validate :follow_itself_validator

  belongs_to :user
  belongs_to :following, class_name: "User", counter_cache: :followers_count

  private

  def follow_itself_validator
    if user_id == following_id
      errors[:you] << "can't follow yourself!"
    end
  end

end
