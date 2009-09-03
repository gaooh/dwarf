# == Schema Information
# Schema version: 6
#
# Table name: dwarves
#
#  id         :integer(11)     not null, primary key
#  name       :string(100)     default(""), not null
#  image_id   :integer(11)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  deleted_at :datetime        
#

class Dwarf < ActiveRecord::Base
end
