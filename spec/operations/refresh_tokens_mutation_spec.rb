require "rails_helper"

describe "Refresh Tokens Mutation API", :graphql do
  describe "refreshTokens" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: RefreshTokensInput!) {
          refreshTokens(input: $input) {
            user {
              email
            }
            refreshToken
            accessToken
          }
        }
      GRAPHQL
    end

    it "provides new refresh and access tokens when provided with a valid refresh token" do
      user = create(:user)
      token_body = RefreshToken.issue(user)

      result = execute query, variables: {
        input: {
          refreshToken: token_body,
        },
      }

      refresh_tokens = result[:data][:refreshTokens]
      expect(refresh_tokens[:user][:email]).to eq(user.email)
      expect(refresh_tokens[:accessToken]).not_to be_nil
      expect(refresh_tokens[:refreshToken]).not_to be_nil
    end
  end
end
