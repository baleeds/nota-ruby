require "rails_helper"

RSpec.describe ResetPassword do
  describe "#call" do
    it "updates a users password and returns an access token and refresh token" do
      user = create(:user)
      reset_token = create(:reset_password_token, :active, user: user)
      old_password = user.password_digest

      result = described_class.new(token_body: reset_token.body, password: "newPassword").call

      expect(result.success?).to be(true)
      expect(result.access_token).not_to be_nil
      expect(result.refresh_token).not_to be_nil
      expect(user.reload.password_digest).not_to eq(old_password)
    end

    it "returns an error if the reset token string is invalid" do
      user = create(:user)
      create(:reset_password_token, user: user)

      result = described_class.new(token_body: "invalidToken", password: "newPassword").call

      expect(result.success?).to be(false)
      expect(result.errors).not_to be_empty
    end

    it "returns an error if the reset token string is expired" do
      user = create(:user)
      reset_token = create(:reset_password_token, :expired, user: user)

      result = described_class.new(token_body: reset_token.body, password: "newPassword").call

      expect(result.success?).to be(false)
      expect(result.errors).not_to be_empty
    end

    it "returns an error if the reset token has already been used" do
      user = create(:user)
      reset_token = create(:reset_password_token, :not_expired, user: user, used: true)

      result = described_class.new(token_body: reset_token.body, password: "newPassword").call

      expect(result.success?).to be(false)
      expect(result.errors).not_to be_empty
    end
  end
end
