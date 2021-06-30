require 'test_helper'

class Mutations::LoginUserTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::LoginUser.new(object: nil, field: nil, context: { session: {} }).resolve(args)
  end

  def create_user
    User.create!(
      first_name: 'Test',
      last_name: 'User',
      username: 'testuser',
      password: '[omitted]'
    )
  end

  test 'success' do
    user = create_user

    result = perform(
      credentials: {
        username: user.username,
        password: user.password
      }
    )

    assert result[:token].present?
    assert_equal result[:user], user
  end

  test 'failure because no credentials' do
    assert_nil perform
  end

  test 'failure because wrong username' do
    create_user
    assert_nil perform(credentials: { username: 'wrong' })
  end

  test 'failure because wrong password' do
    user = create_user
    assert_nil perform(credentials: { username: user.username, password: 'wrong' })
  end
end
