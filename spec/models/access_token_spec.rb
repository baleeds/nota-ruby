require "rails_helper"

RSpec.describe AccessToken do
  describe ".issue" do
    it "creates a token for the provided user" do
      user = create(:user)

      token = AccessToken.issue(user)

      expect(token).not_to be_nil
    end
  end

  describe ".decode" do
    it "it decodes the provided token body" do
      user = create(:user)
      token_body = AccessToken.issue(user)

      decoded_token = AccessToken.decode(token_body)

      expect(decoded_token).to be_a(AccessToken)
      expect(decoded_token.user).to eq(user)
      expect(decoded_token).to be_valid
    end

    it "it decodes the provided invalid token body" do
      decoded_token = AccessToken.decode("invalid-token-body")

      expect(decoded_token).to be_a(AccessToken)
      expect(decoded_token).not_to be_valid
      expect(decoded_token.user).to be_nil
    end
  end

  describe "#user" do
    it "finds a user" do
      user = create(:user)
      token = AccessToken.new(email: user.email)

      result = token.user

      expect(result).to eq(user)
    end

    it "does not find an suspended user" do
      user = create(:user, :suspended)
      token = described_class.new(email: user.email, version: 1)

      result = token.user

      expect(result).to be_nil
    end
  end

  describe "#valid?" do
    it "is valid with a user" do
      user = create(:user)
      token = AccessToken.new(email: user.email)

      expect(token).to be_valid
    end

    it "is invalid without a user" do
      token = AccessToken.new(email: "invalid@email.com")

      expect(token).not_to be_valid
    end
  end
end
