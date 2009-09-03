class DwarvesController < ApplicationController
  #before_filter :dwarf_signin_filter
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @dwarf_pages, @dwarves = paginate :dwarves, :per_page => 10
  end

  def show
    @dwarf = Dwarf.find(params[:id])
  end

  def new
    @dwarf = Dwarf.new
  end

  def create
    @dwarf = Dwarf.new(params[:dwarf])
    @dwarf.image_id = 1 # TODO 画像設定は見直す
    if @dwarf.save
      flash[:notice] = 'Dwarf was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @dwarf = Dwarf.find(params[:id])
  end

  def update
    @dwarf = Dwarf.find(params[:id])
    if @dwarf.update_attributes(params[:dwarf])
      flash[:notice] = 'Dwarf was successfully updated.'
      redirect_to :action => 'show', :id => @dwarf
    else
      render :action => 'edit'
    end
  end

  def destroy
    Dwarf.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
