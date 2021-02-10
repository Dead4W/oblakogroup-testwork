class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title

      t.timestamps
    end

    create_table :todos do |t|
      t.string :text
      t.boolean :isCompleted, :default => false
      t.references :project

      t.timestamps
    end
  end
end
