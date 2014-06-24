class AddTypeToItem < ActiveRecord::Migration
  def change
    add_column :items, :category, :string, :null => false
  end
end
