require 'test_helper'
include Devise::TestHelpers

class ListsControllerTest < ActionController::TestCase


  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:me)
    sign_in @user
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


  test "should copy a list" do
    assert_difference('List.count') do
      post :copy, id: @list
    end
  end


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
