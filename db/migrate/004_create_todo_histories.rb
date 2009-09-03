class CreateTodoHistories < ActiveRecord::Migration
  def self.up
    create_table :todo_histories do |t|
      t.column "todo_id",         :integer,  :null => false
      t.column "user_id",         :integer,  :null => true
      t.column "dwarf_id",        :integer,  :null => true
      t.column "message",         :string,   :null => false,   :limit => 2000
      t.column "created_at",      :datetime,  :null => false
      t.column "updated_at",      :datetime,  :null => false
      t.column "deleted_at",      :datetime,  :null => true
    end
  end

  def self.down
    drop_table :todo_histories
  end
end
