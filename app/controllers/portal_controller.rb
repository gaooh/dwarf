#
# ポータルページ
#
class PortalController < ApplicationController
  #before_filter :header_info, :only => [:index, :graph, :done_list, :term]
  caches_page :done_list, :graph, :rss, :term
  
  def index
    #@todos = Todo.find(:all, :conditions => [' finish_flag = true'], :limit => 5, :order => ['updated_at asc'])
    #
    #begin
    #  client = Twitter::Client.from_config('config/twitter.yml', RAILS_ENV)
    #  @twitters = client.timeline_for(:me)
    #rescue Twitter::RESTError => e
    #  error e
    #end
    render :action => 'index_end'
  end
  
  def graph
  end
  
  def term
  end
  
  def cobit3_graph
    g = Gruff::Line.new 800
    g.title = "Co-bit3 Work Graph!"
    
    labels = Hash.new
    cobit3_count = Array.new(23)
    task_count = Array.new(23)
    
    0.upto(23) do |n|
      labels[n] = n.to_s
      start_at = Time.local(2008, 4, 1, n, 0, 0)
      end_at = Time.local(2008, 4, 1, n, 59, 59)
      cobit3_count[n] = Todo.count(:conditions => ['finish_flag = true and created_at between ? and ?', start_at, end_at])
      task_count[n] = Todo.count(:conditions => ['finish_flag = false and created_at between ? and ?', start_at, end_at])
    end
    g.labels = labels
    g.data("Co-bit3", cobit3_count)
    g.data("Task", task_count)
    
    send_data(g.to_blob, :type => 'image/png')
  end
  
  # 片付けた仕事
  def done_list
    @todos = Todo.find(:all, :conditions => [' finish_flag = true'], :page=>{:size => 10, :current => params[:page]})
  end
  
  # 片付けた仕事RSS
  def rss
    @feed_title = "Co-Bit3"
    @todos = Todo.find(:all, :conditions => [' finish_flag = true'], :limit => 20, :order => ['updated_at asc'])
    render :layout => false
  end
    
end
