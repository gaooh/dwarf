class AccountController < ApplicationController
  before_filter :header_info, :only => [:signin, :new, :create]
  
  # 通常ユーザサインイン
  def signin
  end
  
  # コービットさん用サインイン
  def dwarf_signin
    render :layout => 'dwarf'
  end
  
  # ログアウト処理
  def signout
   session[:user] = nil
   session[:user_id] = nil
   session[:user_name] = nil
   session[:user_email] = nil
   session[:from] = nil
   session[:dwarf] = nil
   redirect_to :controller => :portal, :action => :index
  end
  
  def login
    user = User.find_by_nickname(params[:user][:nickname])
    if !user.nil? && user.password = params[:user][:password]
      session[:user] = user.id
      redirect_to session[:from]
    else
      flash[:warning] = 'ログインに失敗しました'
      render :action => 'signin'
    end
  end
  
  # コービットさんログイン
  def dwarf_login
    dwarf = Dwarf.find_by_name(params[:dwarf][:name])
    if !dwarf.nil? && params[:dwarf][:password] == 'gaooh'
      session[:dwarf] = dwarf.id
      redirect_to session[:from]
    else
      flash[:warning] = "ログインできません"
      render :action => :dwarf_signin
    end
  end
  
  # 新規作成
  def new
  end
  
  def create
    @user = User.new(params[:user])
    @user.openid_url = ''
    if @user.save
      session[:user] = @user.id
      flash[:notice] = 'ユーザを新規登録しました'
      redirect_to :controller => :todos, :action => 'list'
    else
      flash[:warning] = 'ユーザ登録に失敗しました'
      render :action => 'new'
    end    
  end
end
