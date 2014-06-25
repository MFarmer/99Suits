class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :order, index: true
      t.text :content, :null => false
      t.integer :rating, :null => false

      t.timestamps
    end
  end
end
