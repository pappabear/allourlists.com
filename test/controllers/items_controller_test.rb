require 'test_helper'

class ItemsControllerTest < ActionController::TestCase


  setup do
    @item = items(:one)
  end


  test "should create an item" do
    assert_difference('Item.count') do
      post :create, format: :js, item: { name: 'test', is_complete: false }
    end
  end


  test "should update an item" do
    patch :update, format: :js, id: @item, item: { name: @item.name + ' e', is_complete: false }
  end


  test "should destroy an item" do
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item, format: :js
    end
  end


  test "should mark an item complete" do
    put :mark_complete, id: @item, item: { is_complete: true }
    test = Item.find(@item.id)
    assert_equal true, test.is_complete?
  end


  test "should mark an item incomplete" do
    put :mark_incomplete, id: @item, item: { is_complete: false }
    test = Item.find(@item.id)
    assert_equal false, test.is_complete?
  end


end
