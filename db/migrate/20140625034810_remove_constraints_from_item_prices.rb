class RemoveConstraintsFromItemPrices < ActiveRecord::Migration
  def change
    change_column :items, :sale_price, :decimal, :null => true
    change_column :items, :trade_price, :decimal, :null => true
  end
end
