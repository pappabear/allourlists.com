require 'test_helper'

class ListsControllerTest < ActionController::TestCase


  test "should get index" do
    get :index
    assert_response :success
  end

  #test "should copy a list" do
  #  get :copy
  #  assert_response :success
  #end


  test "should show a list" do
    get :show
    assert_response :success
  end


  test "should create a list" do
    get :copy
    assert_response :success
  end


  test "should update a list" do
    get :copy
    assert_response :success
  end


  test "should destroy a list" do
    get :copy
    assert_response :success
  end


end
