class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :room
      t.string :task

      t.timestamps null: false
    end
  end
end
