module Mutations
  class CreateUser < Mutations::BaseMutation
    class AuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInput, required: false
    end

    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :auth_provider, AuthProviderSignupData, required: false

    type Types::UserType

    def resolve(first_name: nil, last_name: nil, auth_provider: nil)
      User.create(
        first_name: first_name,
        last_name: last_name,
        username: auth_provider&.[](:credentials)&.[](:username),
        password: auth_provider&.[](:credentials)&.[](:password)
      )
    end
  end
end
