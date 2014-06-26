class Item < ActiveRecord::Base

  CATEGORY_OPTIONS = ["Armwear", "Belts", "Coats",
                      "Footwear", "Headgear", "Jackets",
                      "Neckwear", "Ponchos", "Robes and Cloaks",
                      "Sports", "Suits", "Tops",
                      "Trousers and Shorts", "Undergarments"]

  CONDITION_OPTIONS = ["New w/ tags", "Never Worn", "Excellent", "Good"]

  # Relationships
  belongs_to :user
  has_many :likes
  has_many :comments
  has_one :order

  # Validations
  if Rails.env.development?
    has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  else
    has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                      :default_url => "/images/:style/missing.png",
                      :storage => :dropbox,
                      :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                      :path => ":style/:id_:filename"
  end

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  validates :title, :condition, :category, :original_price, :description, :weight, :size, :presence => true

  def like_count
    likes = Like.where("item_id = ?", self.id)
    likes.count
  end
end
