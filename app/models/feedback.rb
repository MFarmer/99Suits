class Feedback < ActiveRecord::Base

  # Validations
  validates :rating, :content, :order_id, :presence => true

  # Associations
  belongs_to :order
  has_one(
      :item,
      :through => :order,
      :source => :item
  )
end
