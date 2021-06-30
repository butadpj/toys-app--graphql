require 'test_helper'

class Mutations::CreateUserTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::CreateUser.new(object: nil, field: nil, context: {}).resolve(args)
  end

  test 'create a new user' do
    user = perform(
      first_name: 'Unit',
      last_name: 'Test',
      auth_provider: {
        credentials: {
          username: 'admin',
          password: '[omitted]'
        }
      }
    )

    assert user.persisted?
    assert_equal user.fist_name, 'Unit'
    assert_equal user.last_name, 'Test'
    assert_equal user.username, 'admin'
  end
end
