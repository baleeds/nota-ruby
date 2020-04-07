# frozen_string_literal: true

require 'rails_helper'

describe 'Invalidate Token Mutation API', :graphql do
  describe 'invalidateToken' do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: InvalidateTokenInput!) {
          invalidateToken(input: $input) {
              success
            }
          }
      GRAPHQL
    end

    it "an admin can invalidate a user's token" do
      user = create(:user)

      result = execute query, as: build(:user, :admin),
                              variables: { input: { userId: global_id(user, Outputs::UserType) } }

      result = result[:data][:invalidateToken][:success]

      expect(result).to be(true)
    end
  end
end
