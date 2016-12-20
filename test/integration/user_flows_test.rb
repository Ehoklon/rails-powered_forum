require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  def setup
    @test_user = users(:test_user)
  end

  test 'sign up' do
    post user_registration_path, params:
      { 'user[email]' => 'email@example.com',
        'user[password]' => 'password',
        'user[password_confirmation]' => 'password' }

    assert_redirected_to root_path

    assert User.find_by_email('email@example.com')
  end

  test 'sign in and write an post' do
    post user_session_path, params:
      { 'user[email]' => @test_user.email,
        'user[password]' => 'password' }

    assert_redirected_to root_path

    put new_post_path, params: { 'post[content]' => 'Test Post' }
    assert_redirected_to root_path

    assert Post.where(user_id: @test_user.id, content: 'Test Post')
  end

end