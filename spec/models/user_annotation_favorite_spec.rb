require 'rails_helper'

RSpec.describe UserAnnotationFavorite, type: :model do
  it "is valid with valid attributes" do
    expect(build_stubbed(:user_annotation_favorite)).to be_valid
  end

  it "validates uniqueness of favorite annotation" do
    user = create(:user)
    annotation = create(:annotation)
    create(:user_annotation_favorite, user: user, annotation: annotation)

    result = build(:user_annotation_favorite, user: user, annotation: annotation)

    expect(result).not_to be_valid
  end
end
