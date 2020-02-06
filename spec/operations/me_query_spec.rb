require "rails_helper"

describe "Me Query", :graphql do
  describe "me" do
    let(:query) do
      <<~'GRAPHQL'
        query {
          me {
            id
          }
        }
      GRAPHQL
    end

    it "gets the current user" do
      user = create(:user)

      result = execute query, as: user

      id = result[:data][:me][:id]
      expect(id).to eq(global_id(user, Outputs::UserType))
    end
  end
end
