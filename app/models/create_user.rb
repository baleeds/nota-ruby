class CreateUser
  def initialize(email:, username:, display_name:, password: SecureRandom.base64(10), admin: false)
    @email = email
    @password = password
    @admin = admin
    @username = username
    @display_name = display_name
  end

  def call
    user = User.new(email: email, display_name: display_name, username: username, password: password, admin: admin)

    if user.save
      welcome_user(user)
    else
      Result.failure("user creation error")
    end
  end

  private

  attr_reader :email, :password, :admin, :username, :display_name

  def welcome_user(user)
    token = CreateResetPasswordToken.new(user).call.token

    SendResetPasswordEmailJob.perform_later(user_id: user.id, token_id: token.id)
    Result.success(user: user)
  end
end
