class CreateResetPasswordToken
  def initialize(user)
    @user = user
  end

  def call
    token = ResetPasswordToken.new(user: user)

    if token.save
      send_password_reset_email(token)
      Result.success(token: token)
    else
      Result.failure(token.errors)
    end
  end

  private

  attr_reader :user

  def send_password_reset_email(token)
    SendResetPasswordEmailJob.perform_later(user_id: user.id, token_id: token.id)
  end
end
