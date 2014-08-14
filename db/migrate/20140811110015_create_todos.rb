class CreateTodos < ActiveRecord::Migration
  def up
    create_table :todos do |t|
      t.text :content
      t.boolean :done
      t.datetime :completed_at
      t.timestamps
    end
      end
 
  def down
    drop_table :todos
  end
end
