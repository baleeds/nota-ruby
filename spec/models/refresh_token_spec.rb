require "rails_helper"

RSpec.describe RefreshToken do
  describe ".issue" do
    it "creates a token for the provided user" do
      user = create(:user)

      token_body = RefreshToken.issue(user)

      expect(token_body).not_to be_nil
    end
  end

  describe ".decode" do
    it "it decodes the provided valid token body" do
      user = create(:user)
      token_body = RefreshToken.issue(user)

      decoded_token = RefreshToken.decode(token_body)

      expect(decoded_token).to be_a(RefreshToken)
      expect(decoded_token.user).to eq(user)
      expect(decoded_token).to be_valid
    end

    it "it decodes the provided invalid token body" do
      decoded_token = RefreshToken.decode("invalid-token-body")

      expect(decoded_token).to be_a(RefreshToken)
      expect(decoded_token).not_to be_valid
      expect(decoded_token.user).to be_nil
    end
  end

  describe "#user" do
    it "finds a user" do
      user = create(:user)
      token = RefreshToken.new(email: user.email, version: 1)

      result = token.user

      expect(result).to eq(user)
    end

    it "does not find a suspended user" do
      user = create(:user, :suspended)
      token = described_class.new(email: user.email, version: 1)

      result = token.user

      expect(result).to be_nil
    end
  end

  describe "#valid?" do
    it "is valid if the token version for the user matches the version of the token" do
      user = create(:user, token_version: 1)
      token = RefreshToken.new(email: user.email, version: 1)

      result = token.valid?

      expect(result).to be(true)
    end

    it "is invalid if the token version for the user does not match the version of the token" do
      user = create(:user, token_version: 1)
      token = RefreshToken.new(email: user.email, version: 2)

      result = token.valid?

      expect(result).to be(false)
    end
  end
end
