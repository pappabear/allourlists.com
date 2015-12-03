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


    test 'create new list' do

      #-- login
      get '/users/sign_in'
      assert_response :success

      post_via_redirect '/users/sign_in', 'user[email]' => 'chip.irek@gmail.com', 'user[password]' => 'lollip0p'
      assert_equal '/', path

      #-- get the index
      get '/lists'
      assert_response :success
      assert assigns(:lists)

      post '/lists', 'list[name]' => 'My Integration Test List', :format => 'js'

      # p 'Verifying...'
      l = List.last
      #assert_equal '/lists/' + p.id.to_s, path
      assert_equal l.name, 'My Integration Test List'

    end


    test 'update a list' do

      #-- login
      get '/users/sign_in'
      assert_response :success

      post_via_redirect '/users/sign_in', 'user[email]' => 'chip.irek@gmail.com', 'user[password]' => 'lollip0p'
      assert_equal '/', path

      #-- get the last list created
      l = List.last
      t = l.name += ' -e'

      put '/lists/' + l.id.to_s, 'list[name]' => t, :format => 'js'

      assert_equal '/lists/' + l.id.to_s, path
      l = List.last
      assert_equal l.name, t

    end


    test 'fail adding a list due to missing field' do

      #-- login
      get '/users/sign_in'
      assert_response :success

      post_via_redirect '/users/sign_in', 'user[email]' => 'chip.irek@gmail.com', 'user[password]' => 'lollip0p'
      assert_equal '/', path

      #-- get the last list created
      l = List.last
      t = l.name += ' -e'

      test_failed = false

      begin
        put '/lists/' + l.id.to_s, 'list[name]' => '', :format => 'js'
      rescue => e
        assert_equal("Validation failed: Name can't be blank", e.message)
        test_failed = true
      end

      assert_equal(test_failed, true)

    end


    test 'delete a list' do

      #-- login
      get '/users/sign_in'
      assert_response :success

      post_via_redirect '/users/sign_in', 'user[email]' => 'chip.irek@gmail.com', 'user[password]' => 'lollip0p'
      assert_equal '/', path

      count_before_delete = List.all.count
      l = List.last

      delete '/lists/' + l.id.to_s, :format => 'js'

      count_after_delete = List.all.count
      assert_not_equal count_before_delete, count_after_delete

    end


    test 'create new item' do

      #-- login
      get '/users/sign_in'
      assert_response :success

      post_via_redirect '/users/sign_in', 'user[email]' => 'chip.irek@gmail.com', 'user[password]' => 'lollip0p'
      assert_equal '/', path

      #-- get the list
      get '/lists/1'
      assert_response :success
      assert assigns(:list)

      post '/lists/1/items', 'item[name]' => 'Some test item', :format => 'js'

      # p 'Verifying...'
      i = List.find(1).items.last
      #assert_equal '/lists/' + p.id.to_s, path
      assert_equal i.name, 'Some test item'

    end


    test 'update an item' do

      #-- login
      get '/users/sign_in'
      assert_response :success

      post_via_redirect '/users/sign_in', 'user[email]' => 'chip.irek@gmail.com', 'user[password]' => 'lollip0p'
      assert_equal '/', path

      #-- get the last list created
      i = List.find(1).items.last
      t = i.name += ' -e'

      put '/lists/1/items/' + i.id.to_s, 'item[name]' => t, :format => 'js'

      i = List.find(1).items.last
      assert_equal i.name, t

    end


    test 'fail adding an item due to missing field' do

      #-- login
      get '/users/sign_in'
      assert_response :success

      post_via_redirect '/users/sign_in', 'user[email]' => 'chip.irek@gmail.com', 'user[password]' => 'lollip0p'
      assert_equal '/', path

      #-- get the last list created
      l = List.last

      test_failed = false

      begin
        post '/lists/' + l.id.to_s + '/items', 'item[name]' => '', :format => 'js'
      rescue => e
        assert_equal("Validation failed: Name can't be blank", e.message)
        test_failed = true
      end

      assert_equal(test_failed, true)

    end


    test 'delete an item' do

      #-- login
      get '/users/sign_in'
      assert_response :success

      post_via_redirect '/users/sign_in', 'user[email]' => 'chip.irek@gmail.com', 'user[password]' => 'lollip0p'
      assert_equal '/', path

      count_before_delete = List.find(1).items.count
      i = List.find(1).items.last

      delete '/lists/1/items/' + i.id.to_s, :format => 'js'

      count_after_delete = List.find(1).items.count
      assert_not_equal count_before_delete, count_after_delete

    end


    test 'can only access my own lists' do

      #-- login
      get '/users/sign_in'
      assert_response :success

      post_via_redirect '/users/sign_in', 'user[email]' => 'chip.irek@gmail.com', 'user[password]' => 'lollip0p'
      assert_equal '/', path

      #-- get the list
      get '/lists'
      assert_response :success
      assigns(:lists).each do |l|
        assert_equal(l.user_id, 1)
      end
      #assert_equal 1, assigns(:lists).length

    end


    test 'registration OK' do
      get '/users/sign_up'
      assert_response :success

      post_via_redirect '/users', 'user[name]' => 'New User','user[email]' => 'new_user@gmail.com', 'user[password]' => 'lollip0p', 'user[password_confirmation]' => 'lollip0p'
      assert_equal '/', path
    end


    test 'registration fails with missing fields' do
      get '/users/sign_up'
      assert_response :success

      post_via_redirect '/users', 'user[name]' => 'New User3', 'user[password]' => 'lollip0p'  # no name field!!
      assert_equal '/users', path
    end


end


