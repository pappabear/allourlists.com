require 'test_helper'
include Devise::TestHelpers

class FeedbackEmailsControllerTest < ActionController::TestCase


  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:me)
    sign_in @user
    @item = items(:one)
    @list = lists(:one)
  end


  test "should send feedback" do
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :create, message: { name: 'Tester Man', email: 'chipirek@nc.rr.com', message: 'Regression testing is fun!' }
    end
  end

end