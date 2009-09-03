# == Schema Information
# Schema version: 6
#
# Table name: todos
#
#  id          :integer(11)     not null, primary key
#  user_id     :integer(11)     not null
#  todo        :string(2000)    default(""), not null
#  finish_flag :boolean(1)      not null
#  deadline_at :datetime        
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  deleted_at  :datetime        
#

class Todo < ActiveRecord::Base
  acts_as_paranoid
  
  # --------------------------
  # relation
  # --------------------------
  belongs_to :user
  has_many   :todo_histories
  
  # --------------------------
  # validation
  # --------------------------
  validates_presence_of      :user_id
  validates_presence_of      :todo,      :message=>"内容を記述してください。"
  
  # 未登録なら未登録状態を保持して自分のタスク一覧を返す。
  def self.find_my_all_task(user_id)
    @todos = Todo.find(:all, :conditions => [' user_id = ? ', user_id])
    while @todos.size < 10
      @todos << Todo.new
    end
    return @todos
  end
  
  # # 複数のコービットさんでかぶらないように出題
  def self.find_dwarf_task(dwarf_id, current)
    dwarf_count = Dwarf.count
    find(:all, :conditions => [" finish_flag = false and id%? = ? ", dwarf_count, dwarf_id], :page => {:size => 1, :current => current}) 
  end
  
end
