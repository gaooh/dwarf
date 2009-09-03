class CreateDwarves < ActiveRecord::Migration
  def self.up
    create_table :dwarves do |t|
      t.column "name",            :string,    :null => false,   :limit => 100
      t.column "image_id",        :integer,   :null => false
      t.column "created_at",      :datetime,  :null => false
      t.column "updated_at",      :datetime,  :null => false
      t.column "deleted_at",      :datetime,  :null => true
    end
  end

  def self.down
    drop_table :dwarves
  end
end
