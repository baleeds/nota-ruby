require "rails_helper"

RSpec.describe ApplicationPolicy do
  describe "#logged_in?" do
    it "returns true for a user" do
      user = User.new
      policy = described_class.new(user, nil)

      logged_in = policy.logged_in?

      expect(logged_in).to be(true)
    end

    it "returns false for a guest" do
      user = Guest.new
      policy = described_class.new(user, nil)

      logged_in = policy.logged_in?

      expect(logged_in).to be(false)
    end
  end

  describe "#admin?" do
    it "returns true for an admin user" do
      user = build_stubbed(:user, :admin)
      policy = described_class.new(user, nil)

      admin = policy.admin?

      expect(admin).to be(true)
    end

    it "returns false for a regular user" do
      user = build_stubbed(:user, admin: false)
      policy = described_class.new(user, nil)

      admin = policy.admin?

      expect(admin).to be(false)
    end
  end
end
