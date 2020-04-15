# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ordering model', type: :model do
  class Annotation < ApplicationRecord
    include Orderable

    scope :order_by_text, lambda { |direction|
      order(text: direction)
    }
  end

  describe '.order_by' do
    it 'orders by a scope' do
      verse = create(:verse, id: '1001001')
      second_record = create(:annotation, text: 'b123456789', verse: verse)
      third_record = create(:annotation, text: 'c123456789', verse: verse)
      first_record = create(:annotation, text: 'a123456789', verse: verse)

      ordered = Annotation.order_by(:text, :asc)

      expect(ordered).to eq([first_record, second_record, third_record])
    end
  end
end
