require File.dirname(__FILE__) + '/../test_helper'
require 'dwarves_controller'

# Re-raise errors caught by the controller.
class DwarvesController; def rescue_action(e) raise e end; end

class DwarvesControllerTest < Test::Unit::TestCase
  fixtures :dwarves

  def setup
    @controller = DwarvesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = dwarves(:first).id
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

    assert_not_nil assigns(:dwarves)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:dwarf)
    assert assigns(:dwarf).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:dwarf)
  end

  def test_create
    num_dwarves = Dwarf.count

    post :create, :dwarf => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_dwarves + 1, Dwarf.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:dwarf)
    assert assigns(:dwarf).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Dwarf.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Dwarf.find(@first_id)
    }
  end
end
