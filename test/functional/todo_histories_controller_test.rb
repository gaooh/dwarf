require File.dirname(__FILE__) + '/../test_helper'
require 'todo_histories_controller'

# Re-raise errors caught by the controller.
class TodoHistoriesController; def rescue_action(e) raise e end; end

class TodoHistoriesControllerTest < Test::Unit::TestCase
  fixtures :todo_histories

  def setup
    @controller = TodoHistoriesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = todo_histories(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:todo_histories)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:todo_history)
    assert assigns(:todo_history).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:todo_history)
  end

  def test_create
    num_todo_histories = TodoHistory.count

    post :create, :todo_history => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_todo_histories + 1, TodoHistory.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:todo_history)
    assert assigns(:todo_history).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      TodoHistory.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      TodoHistory.find(@first_id)
    }
  end
end
