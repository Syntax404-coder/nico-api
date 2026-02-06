# frozen_string_literal: true

module Mutations
  class SwipeUser < BaseMutation
    # Arguments for swiping
    argument :target_id, ID, required: true
    argument :direction, String, required: true

    # Return fields - isMatch and matchId as specified
    field :is_match, Boolean, null: false
    field :match_id, ID, null: true
    field :errors, [String], null: false

    # Resolve method to handle swipe creation and match checking
    def resolve(target_id:, direction:)
      user = context[:current_user]

      # Exit early if user is not authenticated
      return { is_match: false, match_id: nil, errors: ['Not authenticated'] } unless user

      # Map direction to action
      action = direction.downcase == 'like' ? 'like' : 'dislike'

      # Create the swipe record
      swipe = user.swipes_made.new(
        swiped_id: target_id,
        action: action
      )

      # Save the swipe and check for match
      if swipe.save
        # Check if match was created
        if swipe.like?
          # Look for existing match
          # The match would have been created in the Swipe model's after_create callback
          match = Match.find_by(
            user1_id: [user.id, target_id.to_i].min,
            user2_id: [user.id, target_id.to_i].max
          )

          # Return match info if found
          if match
            return { is_match: true, match_id: match.id.to_s, errors: [] }
          end
        end

        { is_match: false, match_id: nil, errors: [] }
      else
        { is_match: false, match_id: nil, errors: swipe.errors.full_messages }
      end
    end
  end
end
