require 'test_helper'

class AutomatedRegressionTest < ActionDispatch::IntegrationTest


    fixtures :all


    test 'login and get to index' do

      get '/users/sign_in'
      assert_response :success

      post_via_redirect '/users/sign_in', 'user[email]' => 'chip.irek@gmail.com', 'user[password]' => 'lollip0p'
      assert_equal '/', path

      get '/lists'
      assert_response :success
      assert assigns(:lists)
    end


    test 'unauthenticated_access_blocked' do
      @user = users(:me)

      get '/lists'
      assert_response 302

      request_via_redirect 'get', '/users/sign_in'
      assert_response :success
    end


    test 'attempted sign in fails with bad credentials' do
      get '/users/sign_in'
      assert_response :success

      post_via_redirect '/users/sign_in', 'user[email]' => 'chip.irek@gmail.com', 'user[password]' => 'wrong'
      assert_equal '/users/sign_in', path
      assert_equal 'Invalid email or password.', flash[:alert]
    end


end


