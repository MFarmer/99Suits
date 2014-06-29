class AddStaffPickToItem < ActiveRecord::Migration
  def change
    add_column :items, :staff_pick, :boolean
  end
end
