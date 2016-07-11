class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :task
      t.string :due_date
      t.integer :user_id
    end
  end
end
