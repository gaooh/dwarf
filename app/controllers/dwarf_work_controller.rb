#
# コービットさんお仕事画面
#
class DwarfWorkController < ApplicationController
  before_filter :dwarf_signin_filter
  layout 'dwarf'
  
  # 自分が片付けた仕事一覧とまだ解決していないタスクを１件表示
  def index
    @dwarf_todo = Todo.find_dwarf_task(_dwarf_id, params[:page])
    @todo_histories = TodoHistory.find(:all, :conditions => ['dwarf_id = ?', _dwarf_id])
    @todos = Todo.find(:all, :conditions => [" finish_flag = false "], :page=>{:size => 10, :current => params[:todo_page]})
  end
  
  # 仕事の処理アクション
  def answer
    if params[:skip]
      redirect_to :action => :index, :page => params[:answer][:page].to_i + 1
      return
    elsif params[:delete]
      todo = Todo.find(params[:todo_history][:todo_id])
      todo.destroy
      redirect_to :action => :index
      
    else
      @todo_history = TodoHistory.new(params[:todo_history])
      @todo_history.dwarf_id = _dwarf_id
      @todo_history.save
    
      if params[:todo][:finish_flag] != '0'
        @todo = Todo.find(@todo_history.todo_id)
        @todo.finish_flag = true
        @todo.save
      end
      redirect_to :action => :index
    end
  end
  
  # 画像アップロード処理
  def photo_create
    @photo = Photo.new(params[:photo])
    @photo.save
    
    responds_to_parent do
      render :update do |page|
        page.replace_html 'photoList', render(:partial => 'photo_box')
        page.replace_html 'photoIdForm', render(:partial => 'photo_hidden_field')
      end
    end
  end
  
end
