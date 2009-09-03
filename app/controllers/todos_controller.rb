class TodosController < ApplicationController
  before_filter :header_info, :only => [:index, :list, :user, :show]
  before_filter :signin_filter, :except => [:show, :user]
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  # in_place_edit_for は　update_attribute　を使うため validationが通らない
  #in_place_edit_for :todo, :todo
  def set_todo_todo
    @todo = Todo.find(params[:id])
    before_todo = @todo.todo
    @todo.todo = params[:value]
    if @todo.save
      render :text => @todo.send('todo')
    else
      render :text => before_todo
    end
  end
  
  def list
    @todos = Todo.find_my_all_task(_user_id)
  end

  def user
    @user = User.find_by_nickname(params[:id])
    @todos = Todo.find_my_all_task(@user.id)
  end

  def show
    @todo = Todo.find(params[:id])
    render :action => 'show_end'
  end
  
  def new
    @todo = Todo.new
  end

  def add_new_form
    @todo = Todo.new
  end
  
  def add
    @todo = Todo.new(params[:todo])
    @todo.user_id = _user_id
    if @todo.save
      @todos = Todo.find_my_all_task(_user_id)
    else
      render :action => 'add_error'
    end
  end
  
  def create
    @todo = Todo.new(params[:todo])
    @todo.user_id = _user_id
    if @todo.save
      flash[:notice] = 'Todo was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update_attributes(params[:todo])
      flash[:notice] = 'Todo was successfully updated.'
      redirect_to :action => 'show', :id => @todo
    else
      render :action => 'edit'
    end
  end

  def destroy
    Todo.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
