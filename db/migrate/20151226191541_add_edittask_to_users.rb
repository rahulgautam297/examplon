class AddEdittaskToUsers < ActiveRecord::Migration
  def change
    add_column :users, :edittask_digest, :string
  end
end
