# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendResetPasswordEmailJob, type: :job do
  describe '#perform' do
    it 'sends a email to the specified user' do
      user = create(:user)
      token = create(:reset_password_token, user: user)

      described_class.new.perform(user_id: user.id, token_id: token.id)

      delivery = ActionMailer::Base.deliveries.last
      expect(delivery.to).to include(user.email)
      expect(delivery.body).to include(token.body)
    end
  end
end
