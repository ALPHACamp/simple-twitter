class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
end
