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
      post :create, email: 'chipirek@nc.rr.com', list_id: @list.id, format: :js, invitation: { user_id: @user.id, sent_at: Time.now, password_is_temp: false }
    end
  end


  test "invite friend" do
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :create, email: 'chipirek@nc.rr.com', list_id: @list.id, format: :js, invitation: { user_id: @user.id, sent_at: Time.now, password_is_temp: false }
    end
  end


  test "should accept an invitation" do
    @invitation = invitations(:one)
    get :accept, list_id: @list.id, id: @invitation.id  #, invitation: { user_id: @user.id, sent_at: Time.now, password_is_temp: false }
    assert_redirected_to lists_path(assigns(:lists))
  end


end
