class Item < ActiveRecord::Base

  # Relationships
  belongs_to :user

  # Validations
  validates :title, :condition, :category, :original_price, :description,
            :sale_price, :trade_price, :weight, :size, :presence => true
end
