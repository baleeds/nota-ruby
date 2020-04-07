# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Annotation, type: :model do
  describe 'validation' do
    it 'passes with valid attributes' do
      expect(build_stubbed(:annotation)).to be_valid
    end
  end

  describe '.favorite_for_user' do
    it 'returns annotations favorited by that user' do
      verse = create(:verse, id: '99001001')
      annotation = create(:annotation, verse: verse)
      user = create(:user)

      create(:user_annotation_favorite, annotation: annotation, user: user)
      different_favorited_annotation = create(:user_annotation_favorite)

      annotations = Annotation.favorite_for_user(user)

      expect(annotations).to_not include(different_favorited_annotation)
      expect(annotations.count).to be(1)
      expect(annotations.first).to eq(annotation)
    end
  end

  describe '#favorited?' do
    it 'returns true when a annotation is favorited' do
      annotation = create(:annotation)
      user = create(:user)
      create(:user_annotation_favorite, user: user, annotation: annotation)

      result = annotation.favorited?(user)

      expect(result).to be(true)
    end

    it 'returns false when a annotation is favorited' do
      annotation = create(:annotation)
      user = create(:user)

      result = annotation.favorited?(user)

      expect(result).to be(false)
    end
  end
end
