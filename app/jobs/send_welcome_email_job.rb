class SendWelcomeEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id:, token_id:)
    user = User.find(user_id)
    token = ResetPasswordToken.find(token_id)
    WelcomeMailer.welcome_email(user: user, token: token).deliver_now
  end
end
