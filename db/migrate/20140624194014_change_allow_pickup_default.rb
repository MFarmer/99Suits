class ChangeAllowPickupDefault < ActiveRecord::Migration
  def change
    change_column :items, :allow_pickup, :boolean, :default => false
  end
end
