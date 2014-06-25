class AddShippingTypeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_type, :string, :null => false
  end
end
