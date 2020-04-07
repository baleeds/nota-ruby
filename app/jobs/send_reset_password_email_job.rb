# frozen_string_literal: true

class SendResetPasswordEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id:, token_id:)
    user = User.find(user_id)
    token = ResetPasswordToken.find(token_id)
    PasswordMailer.reset_password(user: user, token: token).deliver_now
  end
end
