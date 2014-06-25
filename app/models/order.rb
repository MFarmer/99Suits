class Order < ActiveRecord::Base

  # Associations
  belongs_to(
      :buyer,
      :class_name => User,
      :foreign_key => :user_id,
      :primary_key => :id
  )
  belongs_to :item
  has_one :feedback

  # Validations
  validates :street, :city, :state, :zip, :purchase_type, :user_id, :item_id, :shipping_type, :presence => true

end
