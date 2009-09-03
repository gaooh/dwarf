class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.column "user_id",         :integer,  :null => false
      t.column "todo",            :string,   :null => false,   :limit => 2000
      t.column "finish_flag",     :boolean,  :null => false,   :default => false
      t.column "deadline_at",     :datetime,  :null => true
      t.column "created_at",      :datetime,  :null => false
      t.column "updated_at",      :datetime,  :null => false
      t.column "deleted_at",      :datetime,  :null => true
    end
  end

  def self.down
    drop_table :todos
  end
end
