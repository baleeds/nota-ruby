# frozen_string_literal: true

require 'rails_helper'

describe 'Create User Mutation API', :graphql do
  describe 'createUser' do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: CreateUserInput!) {
          createUser(input: $input) {
            user {
             email
             isAdmin
            }
          }
        }
      GRAPHQL
    end

    it 'allows an admin to add a user' do
      user_input = {
        email: 'foobar@baz.qux',
        username: 'foobar',
        displayName: 'Foo Bar',
        isAdmin: false
      }

      result = execute query, as: build(:user, :admin), variables: { input: user_input }

      user = result[:data][:createUser][:user]
      expect(user[:email]).to eq(user_input[:email])
      expect(User.count).to eq(1)
    end

    it 'allows an admin to add another admin' do
      user_input = {
        email: 'foobar@baz.qux',
        username: 'foobar',
        displayName: 'Foo Bar',
        isAdmin: true
      }

      result = execute query, as: build(:user, :admin), variables: { input: user_input }

      admin = result[:data][:createUser][:user][:isAdmin]
      expect(admin).to be(true)
    end
  end
end
