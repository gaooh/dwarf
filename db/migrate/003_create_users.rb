class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column "openid_url",         :string,     :limit => 256,   :null => false
      t.column "livedoor_id",        :string,     :limit => 1024,  :null => true
      t.column "hatena_id",          :string,     :limit => 1024,  :null => true
      t.column "nickname",           :string,     :limit => 200,   :null => true
      t.column "password",           :string,     :limit => 200,   :null => true
      t.column "created_at",         :datetime,   :null => false
      t.column "updated_at",         :datetime,   :null => false
      t.column "deleted_at",         :datetime,   :null => true      
    end
  end

  def self.down
    drop_table :users
  end
end
