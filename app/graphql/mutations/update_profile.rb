# frozen_string_literal: true

module Mutations
  class UpdateProfile < BaseMutation
    # Arguments
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :email, String, required: false
    argument :bio, String, required: false
    argument :gender, String, required: false
    argument :gender_interest, String, required: false
    argument :country, String, required: false
    argument :province, String, required: false
    argument :city, String, required: false
    argument :mobile, String, required: false

    # Return fields
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      user = context[:current_user]

      # check authentication
      return { user: nil, errors: ['Not authenticated'] } unless user

      # optionally sanitize mobile input
      args[:mobile] = args[:mobile].gsub(/\D/, '') if args[:mobile]

      # Remove nil values to avoid overwriting with nil
      params = args.compact

      if user.update(params)
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
