require "rails_helper"

RSpec.describe TokenAuthentication do
  it "returns the authenticated user with a valid token" do
    user = create(:user)
    token_body = AccessToken.issue(user)

    authenticated_user = described_class.new(token_string: token_body).authenticate

    expect(authenticated_user).to eq(user)
  end

  it "returns a guest when provided with an invalid token" do
    guest_user = described_class.new(token_string: "not-valid-token").authenticate

    expect(guest_user).to be_a(Guest)
  end
end
