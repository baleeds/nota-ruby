require "rails_helper"

describe "My Checked Out Books Query", :graphql do
  describe "query to see my current checkout history" do
    query =
      <<-'GRAPHQL'
        query {
          myCheckedOutBooks {
            edges {
              node {
                checkedOutAt
            }
          }
        }
      }
      GRAPHQL

    it "returns all checked out books by the current user" do
      user = create(:user)
      checked_out_at = 1.months.ago
      create(:rental, user: user, returned_at: 1.days.ago)
      create(:rental, user: user, created_at: checked_out_at)

      result = execute query, as: user

      rentals_result = result[:data][:myCheckedOutBooks][:edges].pluck(:node)
      expect(rentals_result.first).to include(checkedOutAt: checked_out_at.iso8601)
      expect(rentals_result.count).to eq(1)
    end
  end
end
