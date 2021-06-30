module Mutations
  class CreatePost < Mutations::BaseMutation
    argument :title, String, required: true
    argument :body, String, required: true

    type Types::PostType

    def resolve(title: nil, body: nil)
      Post.create(
        title: title,
        body: body,
        user: context[:current_user]
      )
    end
  end
end
