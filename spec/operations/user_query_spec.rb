require "rails_helper"

describe "User Query", :graphql do
  describe "user" do
    let(:query) do
      <<-'GRAPHQL'
        query($userId: ID!) {
          user(userId: $userId) {
            id
          }
        }
      GRAPHQL
    end

    it "return the specified user" do
      user = create(:user)
      user_id = global_id(user, Outputs::UserType)

      result = execute query, as: build(:user), variables: {
        userId: user_id,
      }

      expect(result[:data][:user]).to include(id: user_id)
    end
  end
end
