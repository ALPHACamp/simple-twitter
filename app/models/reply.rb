class Reply < ApplicationRecord
  belongs_to :tweet ,optional: :ture
end
