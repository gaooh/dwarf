# == Schema Information
# Schema version: 6
#
# Table name: todo_histories
#
#  id         :integer(11)     not null, primary key
#  todo_id    :integer(11)     not null
#  user_id    :integer(11)     
#  dwarf_id   :integer(11)     
#  message    :string(2000)    default(""), not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  deleted_at :datetime        
#  photo_id   :integer(11)     
#

class TodoHistory < ActiveRecord::Base
  
  # --------------------------
  # relation
  # --------------------------
  belongs_to :todo
  belongs_to :dwarf
  belongs_to :photo
  
end
