require "rails_helper"

RSpec.describe Result do
  it "returns a successful result" do
    result = described_class.success(works: true)

    expect(result.success?).to eq(true)
    expect(result.works).to eq(true)
    expect(result.errors).to be_empty
  end

  it "returns a failure result" do
    result = described_class.failure(["did not work"])

    expect(result.success?).to eq(false)
    expect(result.errors).to eq(["did not work"])
  end

  it "accepts a string as an error" do
    result = described_class.failure("did not work")

    expect(result.success?).to eq(false)
    expect(result.errors).to eq(["did not work"])
  end
end
