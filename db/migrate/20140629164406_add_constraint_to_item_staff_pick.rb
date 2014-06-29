class AddConstraintToItemStaffPick < ActiveRecord::Migration
  def change
    change_column :items, :staff_pick, :boolean, :default => false
  end
end
