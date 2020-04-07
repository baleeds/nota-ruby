# frozen_string_literal: true

require 'rails_helper'

describe 'Users Query', :graphql do
  describe 'users' do
    let(:query) do
      <<-'GRAPHQL'
        query {
          users {
            edges {
              node {
                email
              }
            }
          }
        }
      GRAPHQL
    end

    it 'returns a list of users' do
      user = create(:user, email: 'test@test.com')

      result = execute query, as: build(:user)

      users_result = result[:data][:users][:edges].pluck(:node)
      expect(users_result).to include(email: user.email)
    end
  end
end
