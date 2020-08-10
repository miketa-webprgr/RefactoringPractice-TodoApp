class RemoveAdminFromUsers < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :admin
  end

  def down
    add_column :users, :admin, :boolean, default: false
  end
end
