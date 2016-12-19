require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'should not save empty' do
    comment = Comment.new
    assert !comment.save
  end

  test 'should not save with unexist user' do
    comment = Comment.new do |comment|
      comment.comment = 'Test Content'
      comment.user = nil
      comment.post = posts(:test_post)
    end
    assert !comment.save
  end

  test 'should not save with unexist artcile' do
    comment = Comment.new do |comment|
      comment.comment = 'Test Content'
      comment.user = users(:test_user)
      comment.post = nil
    end
    assert !comment.save
  end

  test 'should save valid comment' do
    comment = Comment.new do |comment|
      comment.comment = 'Test Content'
      comment.user = users(:test_user)
      comment.post = posts(:test_post)
    end
    assert comment.save
  end
end
