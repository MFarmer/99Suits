class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :user, index: true
      t.string :brand, :null => false
      t.string :condition, :null => false
      t.decimal :original_price, :null => false
      t.text :description, :null => false
      t.decimal :sale_price, :null => false
      t.integer :trade_price, :null => false
      t.boolean :allow_pickup, :null => false
      t.decimal :weight, :null => false
      t.string :size, :null => false

      t.timestamps
    end
  end
end
