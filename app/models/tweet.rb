class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  belongs_to :user
  has_many :replies, dependent: :destroy

  # Like
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user # 指名 user Model name，但不大寫

  # 排序
  # default_scope :include => :likes, :order => "likes.created_at desc"
  scope :ordered, -> { includes(:likes).order('likes.created_at asc') }

  def is_liked?(user)
    self.liked_users.include?(user)
  end

end
