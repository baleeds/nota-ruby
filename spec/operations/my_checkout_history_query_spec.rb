require "rails_helper"

describe "My Checkout History Query", :graphql do
  describe "query to see my current checkout history" do
    query =
      <<-'GRAPHQL'
        query {
          myCheckoutHistory {
            edges {
              node {
                checkedOutAt
                returnedAt
            }
          }
        }
      }
      GRAPHQL

    it "returns complete rental history for user querying it" do
      user = create(:user)
      oldest_rental = create(
        :rental,
        user: user,
        created_at: 2.months.ago,
        returned_at: 1.month.ago
      )
      newest_rental = create(:rental, user: user, created_at: 1.month.ago)

      result = execute query, as: user

      rentals_result = result[:data][:myCheckoutHistory][:edges].pluck(:node)

      expect(rentals_result.first).to include(
        checkedOutAt: newest_rental.created_at.iso8601,
        returnedAt: nil
      )

      expect(rentals_result.last).to include(
        checkedOutAt: oldest_rental.created_at.iso8601,
        returnedAt: oldest_rental.returned_at.iso8601
      )
    end
  end
end
