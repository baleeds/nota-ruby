require "rails_helper"

describe "Sign In User Mutation API", :graphql do
  describe "signInUser" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: SignInUserInput!) {
          signInUser(input: $input) {
            accessToken
            refreshToken
            user {
              email
            }
            errors {
              field
              message
            }
          }
        }
      GRAPHQL
    end

    it "issues new access and refresh tokens" do
      user = create(:user, password: "tester12")

      result = execute query, variables: {
        input: {
          email: user.email,
          password: "tester12",
        },
      }

      sign_in_user = result[:data][:signInUser]
      email = sign_in_user[:user][:email]
      expect(email).to eq(user.email)
      expect(sign_in_user[:accessToken]).not_to be_nil
      expect(sign_in_user[:refreshToken]).not_to be_nil
    end

    it "does not authenticate with invalid email" do
      create(:user, password: "tester12")

      result = execute query, variables: {
        input: {
          email: "invalid@email.com",
          password: "tester12",
        },
      }

      response = result[:data][:signInUser]
      expect(response[:errors]).not_to be_empty
      expect(response[:user]).to be_nil
      expect(response[:token]).to be_nil
    end

    it "does not authenticate with invalid password" do
      user = create(:user, password: "tester12")

      result = execute query, variables: {
        input: {
          email: user.email,
          password: "not_tester",
        },
      }

      response = result[:data][:signInUser]
      expect(response[:errors]).not_to be_empty
      expect(response[:user]).to be_nil
      expect(response[:token]).to be_nil
    end
  end
end
