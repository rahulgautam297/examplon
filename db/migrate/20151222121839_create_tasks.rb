class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :task
      t.references :user, index: true, foreign_key: true
      t.text :location
      t.datetime :time

      t.timestamps null: false
    end
    add_index :tasks, [:user_id, :created_at]
  end
end
