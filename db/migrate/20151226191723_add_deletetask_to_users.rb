class AddDeletetaskToUsers < ActiveRecord::Migration
  def change
    add_column :users, :deletetask_digest, :string
  end
end
