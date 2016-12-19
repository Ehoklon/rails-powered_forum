require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save empty' do
  user = User.new
  assert !user.save
end

test 'should not save without email' do
  user = User.new do |user|
    user.email = ''
    user.password = 'password'
    user.password_confirmation = 'password'
  end
  assert !user.save
end

test 'should not save without password' do
  user = User.new do |user|
    user.email = 'example@test.com'
    user.encrypted_password = ''
  end
  assert !user.save
end

test 'should not save already exist' do
  test_user = users(:test_user)
  user = User.new do |user|
    user.email = test_user.email
    user.password = 'password'
    user.password_confirmation = 'password'
  end
  assert !user.save
end

test 'should save valid user' do
  user = User.new do |user|
    user.email = 'example@test.com'
    user.password = 'password'
    user.password_confirmation = 'password'
  end
  assert user.save
end
end
