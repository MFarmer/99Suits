class AddTitleToItem < ActiveRecord::Migration
  def change
    add_column :items, :title, :string, :null => false
  end
end
