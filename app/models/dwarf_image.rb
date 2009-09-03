# == Schema Information
# Schema version: 6
#
# Table name: dwarf_images
#
#  id           :integer(11)     not null, primary key
#  dwarf_id     :integer(11)     
#  filename     :string(256)     default(""), not null
#  org_filename :string(256)     default(""), not null
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  deleted_at   :datetime        
#

class DwarfImage < ActiveRecord::Base
end
