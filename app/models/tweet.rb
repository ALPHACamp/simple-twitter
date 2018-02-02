class Tweet < ApplicationRecord
  before_action :authenticate_user!
  validates_length_of :description, maximum: 140


end
