require "rails_helper"

RSpec.describe Annotation, type: :model do
  describe "validation" do
    it "passes with valid attributes" do
      expect(build_stubbed(:annotation)).to be_valid
    end
  end
end