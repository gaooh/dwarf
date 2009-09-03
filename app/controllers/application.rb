# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_dwarf_rails_session_id'
  # jpmobile 
  mobile_filter :hankaku=>true
  
  layout :basic_layout
  def basic_layout
    if request.mobile?
      "mobile"
    else
      'basic'
    end
    "end"
  end
  
  #=== _user_id
  # ログイン中のユーザIDを返す
  def _user_id
    session[:user]
  end
  
  #=== _dwarf_id
  # ログイン中のコービットさんIDを返す
  def _dwarf_id
    session[:dwarf]
  end
  
  #=== _user_name
  # ログイン中のユーザ名を返す
  def _user_name
    session[:user_name]
  end
  
  def _from
    session[:from].nil? ? "/" : session[:from]
  end
  
  #=== request_uri
  # リクエスト元URLをかえす
  def _request_uri
    request.env["REQUEST_URI"]
  end
  
  #=== signin_filter
  # 認証が必要なページにかけられるfilter
  # 未認証ならサインインページへリダイレクトさせる。
  def signin_filter
    helper_sigin_filter('signin') unless is_authorized
  end
  
  #=== signin_filter
  # コービットさん認証が必要なページにかけられるfilter
  # 未認証ならサインインページへリダイレクトさせる。
  def dwarf_signin_filter
    helper_sigin_filter('dwarf_signin') unless is_dwarf_authorized
  end
    
  #=== debug
  # debugログをロギングする
  def debug(message)
    logger.debug("[NAVI]: #{message}")
  end

  #=== info
  # infoログをロギングする
  def info(message)
    logger.info("[NAVI]: #{message}")
  end

  #=== error
  # errorログをロギングする
  def error(message)
    logger.error("[NAVI]: #{message}")
  end
  
  #=== is_authorized
  # 認証しているかどうかを判別する
  def is_authorized
    return false unless session
    return false unless session[:user]
    return true
  end
  
  #=== is_dwarf_authorized
  # コービットさん認証しているかどうかを判別する
  def is_dwarf_authorized
    return false unless session
    return false unless session[:dwarf]
    return true
  end
  
  private 
    def helper_sigin_filter(action_name)
      r_uri = request.env["REQUEST_URI"]
      if r_uri == "/account/#{action_name}"
        session[:from] = "/"
      else
        session[:from] = r_uri
      end

      redirect_to :controller => 'account', :action => action_name
    end
    
    def header_info
      @count_all_todo = Todo.count
      @count_finish_todo = Todo.count(:conditions => [' finish_flag = true'])
      @task_rate = @count_finish_todo.to_f / @count_all_todo.to_f * 100 unless @count_all_todo == 0
    end
end
