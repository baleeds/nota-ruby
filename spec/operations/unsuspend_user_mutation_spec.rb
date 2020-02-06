require "rails_helper"

describe "Unsuspend User Mutation API", :graphql do
  describe "unsuspendUser" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: UnsuspendUserInput!) {
          unsuspendUser(input: $input) {
            user {
              isActive
            }
          }
        }
      GRAPHQL
    end

    it "unsuspends a user" do
      acting_user = build(:user, :admin)
      user = create(:user, active: false)

      execute query, as: acting_user, variables: {
        input: {
          userId: global_id(user, Outputs::UserType),
        },
      }

      expect(user.reload.active).to be(true)
    end
  end
end
