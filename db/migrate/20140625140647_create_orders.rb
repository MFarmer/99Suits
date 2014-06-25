class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.references :item, index: true
      t.string :purchase_type, :null => false
      t.datetime :shipping_date
      t.string :street, :null => false
      t.string :city, :null => false
      t.string :state, :null => false
      t.string :zip, :null => false

      t.timestamps
    end
  end
end
