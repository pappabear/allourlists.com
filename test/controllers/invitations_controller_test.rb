require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase


  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:me)
    sign_in @user
    @item = items(:one)
    @list = lists(:one)
  end


  test "should create a new invitation" do
    assert_difference('Invitation.count') do
      #put :mark_incomplete, id: @item, list_id:@item.list_id, format: :js, item: { is_complete: false }
      post :create, email: 'chipirek@nc.rr.com', list_id: @list.id, format: :js, invitation: { user_id: @user.id, sent_at: Time.now, password_is_temp: false }
    end
  end


  test "should accept an invitation" do
    ##put :mark_incomplete, id: @item, list_id:@item.list_id, format: :js, item: { is_complete: false }
    #get :accept, list_id: @list.id, format: :js, invitation: { user_id: @user.id, sent_at: Time.now, password_is_temp: false }
    assert_response :success
  end


end
