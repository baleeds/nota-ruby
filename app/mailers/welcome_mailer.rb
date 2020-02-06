class WelcomeMailer < ApplicationMailer
  def welcome_email(user:, token:)
    @user = user
    @token = token.body

    mail(to: @user.email, subject: "Welcome to Nota")
  end
end
