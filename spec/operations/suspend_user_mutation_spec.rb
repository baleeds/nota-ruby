# frozen_string_literal: true

require 'rails_helper'

describe 'Suspend User Mutation API', :graphql do
  describe 'suspendUser' do
    query =
      <<~'GRAPHQL'
        mutation($input: SuspendUserInput!) {
          suspendUser(input: $input) {
            user {
              isActive
            }
          }
        }
      GRAPHQL

    it 'suspends a user' do
      acting_user = build(:user, :admin)
      user = create(:user, active: true)

      execute query, as: acting_user, variables: {
        input: {
          userId: global_id(user, Outputs::UserType)
        }
      }

      expect(user.reload.active).to be(false)
    end
  end

  describe 'failure to suspend self' do
    query =
      <<~'GRAPHQL'
        mutation($input: SuspendUserInput!) {
          suspendUser(input: $input) {
            errors {
              message
            }
          }
        }
      GRAPHQL
    it 'fails to suspend yourself' do
      acting_user = create(:user, :admin)

      result = execute query, as: acting_user, variables: {
        input: {
          userId: global_id(acting_user, Outputs::UserType)
        }
      }

      errors = result[:data][:suspendUser][:errors]
      expect(errors).to_not be(nil)
    end
  end
end
