class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140,:message => "限字140"
  belongs_to :user

end
