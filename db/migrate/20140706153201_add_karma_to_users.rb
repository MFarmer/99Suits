class AddKarmaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :karma, :integer, :default => 1000
  end
end
