class DropStaffPickTable < ActiveRecord::Migration
  def change
    drop_table :staff_picks
  end
end
