class ProjectTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :project_todos, :id => false do |t|
      t.integer :todo_id
      t.integer :project_id
    end
  end
end
