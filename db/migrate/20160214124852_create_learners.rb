class CreateLearners < ActiveRecord::Migration
  def change
    create_table :learners do |t|
      t.string :name
      t.references :group, index: true, foreign_key: true
      t.text :notes
      t.integer :role ,default: 0

      t.timestamps null: false
    end
  end
end
