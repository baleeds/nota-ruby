# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::Error do
  describe '#call' do
    it 'maps an error array to a consistent format' do
      result = subject.call({ errors: ['This is invalid'] }, {}, {})

      expect(result).to eq([field: :base, message: 'This is invalid'])
    end
  end
end
