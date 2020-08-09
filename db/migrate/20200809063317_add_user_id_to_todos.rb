class AddUserIdToTodos < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM todos;'
    add_reference :todos, :user, null: false, index: true
  end

  def down
    remove_reference :todos, :user, index: true
  end
end
