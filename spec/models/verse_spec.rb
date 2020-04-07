# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Verse, type: :model do
  describe '#number_of_annotations' do
    it 'returns the correct number' do
      verse = create(:verse)
      user = create(:user)
      second_user = create(:user)

      create(:annotation, verse: verse, user: user)
      create(:annotation, verse: verse, user: user)
      create(:annotation, verse: verse, user: second_user)

      expect(verse.number_of_annotations).to be(3)
      expect(verse.number_of_annotations_for_user(user)).to be(2)
      expect(verse.number_of_annotations_for_user(second_user)).to be(1)
    end
  end
end
