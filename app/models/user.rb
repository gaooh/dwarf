# == Schema Information
# Schema version: 6
#
# Table name: users
#
#  id          :integer(11)     not null, primary key
#  openid_url  :string(256)     default(""), not null
#  livedoor_id :string(1024)    
#  hatena_id   :string(1024)    
#  nickname    :string(200)     
#  password    :string(200)     
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  deleted_at  :datetime        
#


# this model expects a certain database layout and its based on the name/login pattern. 
class User < ActiveRecord::Base
  acts_as_paranoid

  # --------------------------
  # validation
  # --------------------------
  validates_presence_of   :nickname,      :message=>"ニックネームを記述してください。"
  validates_uniqueness_of :nickname, :on => :create
  validates_presence_of   :password
  validates_format_of     :password, :with => /^[0-9a-zA-Z]+$/, :message => 'パスワードは英数字の大小文字しか使えません'
  
  def self.get(openid_url)
    find_first(["openid_url = ?", openid_url])
  end  
  
end
