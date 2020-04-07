# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ResetPasswordToken, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      expect(build(:reset_password_token)).to be_valid
    end

    it 'is not valid if token is not unique' do
      reset_password_token = create(:reset_password_token)
      another_reset_password_token = build(:reset_password_token, body: reset_password_token.body)

      expect(another_reset_password_token).not_to be_valid
    end
  end

  describe '.active' do
    it 'can find active tokens' do
      token = create(:reset_password_token, :active)

      found_token = described_class.active.first

      expect(found_token).to eq(token)
    end

    it 'does not find expired tokens' do
      create(:reset_password_token, :expired)

      found_token = described_class.active.first

      expect(found_token).to be(nil)
    end

    it 'does not find used tokens' do
      create(:reset_password_token, :active, used: true)

      found_token = described_class.active.first

      expect(found_token).to be(nil)
    end
  end

  describe '.find_active' do
    it 'returns a token from body' do
      user = create(:user)
      reset_password_token = create(:reset_password_token, :active, user: user)

      result = described_class.find_active(reset_password_token.body)

      expect(result).to eq(reset_password_token)
    end

    it 'does not return a non-active token' do
      user = create(:user)
      reset_password_token = create(:reset_password_token, :expired, user: user)

      result = described_class.find_active(reset_password_token.body)

      expect(result).to eq(nil)
    end
  end

  describe '#use' do
    it 'sets used to true' do
      token = build(:reset_password_token, used: false)

      result = token.use

      expect(result).to be(true)
      expect(token.used).to be(true)
    end
  end
end
