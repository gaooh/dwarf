# == Schema Information
# Schema version: 6
#
# Table name: photos
#
#  id         :integer(11)     not null, primary key
#  filename   :string(256)     default(""), not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  deleted_at :datetime        
#

class Photo < ActiveRecord::Base
  acts_as_paranoid
  
  file_column :filename, :magick => {
      :versions => {
        :thumb        => "70x70",
        :midle        => "104x104",
        :large        => "162x162",
        :extra_large  => "232x232"
      }
  }, :web_root => "system/files/", :root_path => File.join(RAILS_ROOT, "public", "system", "files")
  
end
