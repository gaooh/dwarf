require File.dirname(__FILE__) + '/../test_helper'
require 'dwarf_work_controller'

# Re-raise errors caught by the controller.
class DwarfWorkController; def rescue_action(e) raise e end; end

class DwarfWorkControllerTest < Test::Unit::TestCase
  def setup
    @controller = DwarfWorkController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
