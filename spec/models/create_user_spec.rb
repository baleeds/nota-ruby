require "rails_helper"

RSpec.describe CreateUser do
  describe "#call" do
    it "creates a user" do
      create(:user, :admin)
      email = "foo@bar.baz"

      result = described_class.new(email: email, username: "guy", display_name: "Sir Guy").call

      expect(result.success?).to be(true)
      expect(User.count).to eq(2)
    end

    it "lets an admin create another admin" do
      create(:user, :admin)
      email = "foo@bar.baz"

      result = described_class.new(email: email, username: "guy", display_name: "Sir Guy", admin: true).call

      expect(result.success?).to be(true)
      expect(User.where(admin: true).count).to eq(2)
    end

    it "sends a welcome email" do
      email = "foo@bar.baz"

      result = perform_enqueued_jobs {
        described_class.new(email: email, username: "guy", display_name: "Sir Guy").call
      }

      delivery = ActionMailer::Base.deliveries.last
      expect(delivery.to).to include(email)
      expect(result.success?).to be(true)
    end

    it "returns an error if user is invalid" do
      email = "bravesirrobbin@camelot.com"
      password = "2short"

      result = described_class.new(email: email, username: "guy", display_name: "Sir Guy", password: password).call

      expect(result.success?).to be(false)
      expect(User.count).to eq(0)
    end
  end
end
