class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :text
      t.boolean :isCompleted, :default => false
      t.references :project

      t.timestamps
    end
  end
end
