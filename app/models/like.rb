class Like < ApplicationRecord
  belongs_to :user #一個like屬於一個使用者 
  belongs_to :tweet #一個like屬於一個tweet 
end
