require "rails_helper"

RSpec.describe Guest, type: :model do
  describe "#guest?" do
    it "returns true" do
      user = Guest.new

      result = user.guest?

      expect(result).to be(true)
    end
  end

  describe "#admin?" do
    it "returns false" do
      user = Guest.new

      result = user.admin?

      expect(result).to be(false)
    end
  end
end
