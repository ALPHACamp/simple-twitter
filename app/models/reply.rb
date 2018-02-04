class Reply < ApplicationRecord
  belongs_to :tweet ,optional: :ture
  belongs_to :user, optional: :ture
end
