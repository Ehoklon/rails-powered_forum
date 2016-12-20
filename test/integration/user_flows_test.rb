require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  def setup
    @test_user = users(:test_user)
  end

  test 'sign up' do
    post user_registration_path, params: {
      user:
      { email: 'email@example.com',
        password: 'password',
        password_confirmation: 'password' }
    }

    assert_redirected_to root_path

    assert User.find_by_email('email@example.com')
  end

  test 'sign in and write an post' do
    post user_session_path, params: {
      user:
        { email: @test_user.email,
        password: 'password' }
    }

    assert_redirected_to root_path

    post posts_path, params: {
      post:
      { title: 'Post Title',
        content: 'Post Content' }
    }

    assert post = Post.find_by(user_id: @test_user.id, content: 'Post Content')
    assert_redirected_to '/posts/' + post.id.to_s
  end

  test 'sign in and write a comment' do
    post user_session_path, params: {
      user:
        { email: @test_user.email,
        password: 'password' }
    }

    assert_redirected_to root_path

    post post_comments_path(post_id: posts(:test_post).id), params: {
      comment:
      { comment: 'The Comment' }
    }

    assert Comment.find_by(user_id: @test_user.id, comment: 'The Comment', post_id: posts(:test_post).id)
  end

  test 'fail sign up' do
    post user_registration_path, params: {
      user:
      { email: 'email@example.com',
        password: 'password',
        password_confirmation: 'password1' }
    }

    assert_response :success # Controller didn't redirect to root_path
  end


  test 'sign in and fail to write an post' do
    post user_session_path, params: {
      user:
        { email: @test_user.email,
        password: 'password' }
    }

    assert_redirected_to root_path

    post posts_path, params: {
      post:
      { title: 'Post Title',
        content: '' }
    }

    assert !Post.exists?(user_id: @test_user.id, content: 'Post Content')
  end

  test 'sign in and fail to write a comment' do
    post user_session_path, params: {
      user:
        { email: @test_user.email,
        password: 'password' }
    }

    assert_redirected_to root_path

    post post_comments_path(post_id: posts(:test_post).id), params: {
      comment:
      { comment: '' }
    }

    assert !Comment.exists?(user_id: @test_user.id, comment: 'The Comment', post_id: posts(:test_post).id)
  end
end
