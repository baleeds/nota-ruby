require "rails_helper"

describe "Update Password Mutation API", :graphql do
  describe "updatePassword" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: UpdatePasswordInput!) {
          updatePassword(input: $input) {
            user {
              id
            }
            errors {
              field
            }
          }
        }
      GRAPHQL
    end

    it "updates a users password if the current password is correct" do
      user = create(:user, password: "current_password")
      original_password = user.password_digest

      result = execute query, as: user, variables: {
        input: {
          currentPassword: "current_password",
          newPassword: "new_password",
        },
      }

      expect(result[:data][:updatePassword][:errors]).to be_empty
      expect(user.reload.password_digest).not_to eq(original_password)
    end
  end
end
