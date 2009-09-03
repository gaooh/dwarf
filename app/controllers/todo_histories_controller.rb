class TodoHistoriesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @todo_history_pages, @todo_histories = paginate :todo_histories, :per_page => 10
  end

  def show
    @todo_history = TodoHistory.find(params[:id])
  end

  def new
    @todo_history = TodoHistory.new
  end

  def create
    @todo_history = TodoHistory.new(params[:todo_history])
    if @todo_history.save
      flash[:notice] = 'TodoHistory was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @todo_history = TodoHistory.find(params[:id])
  end

  def update
    @todo_history = TodoHistory.find(params[:id])
    if @todo_history.update_attributes(params[:todo_history])
      flash[:notice] = 'TodoHistory was successfully updated.'
      redirect_to :action => 'show', :id => @todo_history
    else
      render :action => 'edit'
    end
  end

  def destroy
    TodoHistory.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
