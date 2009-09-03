class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.column "filename",           :string,     :limit => 256, :null => false
      t.column "created_at",         :datetime,   :null => false
      t.column "updated_at",         :datetime,   :null => false
      t.column "deleted_at",         :datetime,   :null => true
    end
    add_column(:todo_histories, :photo_id,  :integer,  :null => true)
  end

  def self.down
    drop_table :photos
    remove_column(:todo_histories, :photo_id)
  end
end
