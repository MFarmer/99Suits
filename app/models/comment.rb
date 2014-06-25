class Comment < ActiveRecord::Base
  belongs_to(
      :author,
      :class_name => User,
      :foreign_key => :user_id,
      :primary_key => :id
  )
  belongs_to :item
end
