class AddConstraintToItemHidden < ActiveRecord::Migration
  def change
    change_column :items, :hidden, :boolean, :default => false
  end
end
