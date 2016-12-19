require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'should not save empty' do
    post = Post.new
    assert !post.save
  end

  test 'should not save with unexist user' do
    post = Post.new do |post|
      post.content = 'Test Content'
      post.user_id = 0
    end
    assert !post.save
  end

  test 'should save valid post' do
    post = Post.new do |post|
      post.content = 'Test Content'
      post.user_id = users(:test_user).id
    end
    assert post.save
  end
end
