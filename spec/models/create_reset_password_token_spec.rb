# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateResetPasswordToken do
  describe '#call' do
    it 'creates a reset password token for user and triggers an email' do
      user = create(:user)

      result = perform_enqueued_jobs do
        described_class.new(user).call
      end

      expect(result.success?).to be(true)
      expect(ResetPasswordToken.where(user: user).count).to eq(1)
      delivery = ActionMailer::Base.deliveries.last
      expect(delivery).not_to eq(nil)
    end
  end
end
