class Item < ActiveRecord::Base

  # Relationships
  belongs_to :user

  # Validations
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  validates :title, :condition, :category, :original_price, :description,
            :sale_price, :trade_price, :weight, :size, :presence => true
end
