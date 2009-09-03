class CreateDwarfImages < ActiveRecord::Migration
  def self.up
    create_table :dwarf_images do |t|
      t.column "dwarf_id",           :integer
      t.column "filename",           :string,     :limit => 256, :null => false
      t.column "org_filename",       :string,     :limit => 256, :default => "", :null => false
      t.column "created_at",         :datetime,   :null => false
      t.column "updated_at",         :datetime,   :null => false
      t.column "deleted_at",         :datetime,   :null => true
    end
  end

  def self.down
    drop_table :dwarf_images
  end
end
