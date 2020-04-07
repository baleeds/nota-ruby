# frozen_string_literal: true

class ResetPassword
  def initialize(token_body:, password:)
    @token_body = token_body
    @password = password
  end

  def call
    reset_token = ResetPasswordToken.find_active(token_body)

    if reset_token
      use_token(reset_token)
    else
      Result.failure('Password reset is expired or invalid')
    end
  end

  private

  attr_reader :token_body, :password

  def use_token(reset_token)
    user = reset_token.user
    if user.update(password: password)
      reset_token.use
      Result.success(
        user: user,
        access_token: AccessToken.issue(user),
        refresh_token: RefreshToken.issue(user)
      )
    else
      Result.failure(user.errors)
    end
  end
end
