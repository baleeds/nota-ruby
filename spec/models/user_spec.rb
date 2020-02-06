require "rails_helper"

RSpec.describe User, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      expect(build(:user)).to be_valid
    end

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }

    it "is not valid with a non-unique email" do
      user = create(:user)
      duplicate_user = build(:user, email: user.email)

      expect(duplicate_user).not_to be_valid
    end
  end

  describe ".active" do
    it "can find active users" do
      active_user = create(:user, :active)
      suspended_user = create(:user, :suspended)

      results = described_class.active

      expect(results).to include(active_user)
      expect(results).not_to include(suspended_user)
    end
  end

  describe "#update_password" do
    it "confirms the current password and then changes it" do
      user = create(:user, password: "original")
      original_password = user.password_digest

      result = user.update_password(current: "original", new: "new_password")

      expect(result).to be(true)
      expect(user.reload.password_digest).not_to eq(original_password)
    end

    it "does not update the password if the provided current password does not match" do
      user = create(:user, password: "original")
      original_password = user.password_digest

      result = user.update_password(current: "not_a_match", new: "new_password")

      expect(result).to be(false)
      expect(user.reload.password_digest).to eq(original_password)
    end
  end

  describe "#suspend" do
    it "makes the user inactive" do
      user = create(:user, active: true)

      user.suspend

      expect(user).not_to be_active
    end
  end

  describe "#guest?" do
    it "returns false" do
      user = build_stubbed(:user)

      result = user.guest?

      expect(result).to be(false)
    end
  end
end
