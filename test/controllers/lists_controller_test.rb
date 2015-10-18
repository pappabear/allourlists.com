require 'test_helper'


class ListsControllerTest < ActionController::TestCase


  setup do
    @list = lists(:one)
  end


  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lists)
  end


  test "should show a list" do
    get :show, id: @list
    assert_response :success
    assert_not_nil assigns(:list)
  end


  #test "should copy a list" do
  #  get :copy
  #  assert_response :success
  #end


  test "should create a list" do
    assert_difference('List.count') do
      post :create, format: :js, list: { name: 'test' }
    end
  end


  test "should update a list" do
    patch :update, format: :js, id: @list, list: { name: @list.name + ' e' }
  end


  test "should destroy a list" do
    assert_difference('List.count', -1) do
      delete :destroy, id: @list, format: :js
    end
  end


end
