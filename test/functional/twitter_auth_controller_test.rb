require 'test_helper'

class TwitterAuthControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get start" do
    get :start
    assert_response :success
  end

  test "should get callback" do
    get :callback
    assert_response :success
  end

  test "should get oclient" do
    get :oclient
    assert_response :success
  end

end
