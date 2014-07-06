class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user, index: true
      t.string :description
      t.references :activitiable, polymorphic: true
      t.timestamps
    end
  end
end
