class PasswordMailer < ApplicationMailer
  def reset_password(user:, token:)
    @user = user
    @token = token.body
    @date = Date.current

    mail(to: @user.email, subject: "Reset Password - Nota")
  end
end
