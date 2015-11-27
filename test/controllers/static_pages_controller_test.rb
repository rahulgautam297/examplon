require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Examplon"
  end

  test "should get developer" do
    get :about
    assert_response :success
    assert_select "title", "Developer | Examplon"
  end

end
