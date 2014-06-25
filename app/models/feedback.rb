class Feedback < ActiveRecord::Base
  belongs_to :order
  has_one(
      :item,
      :through => :order,
      :source => :item
  )
end
