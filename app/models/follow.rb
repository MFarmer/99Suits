class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to(
      :followed_user,
      :class_name => User,
      :foreign_key => :following_id,
      :primary_key => :id
  )
end
