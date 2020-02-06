class CredentialAuthentication
  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def authenticate
    if user&.authenticate(password)
      Result.success(
        access_token: AccessToken.issue(user),
        refresh_token: RefreshToken.issue(user),
        user: user
      )
    else
      Result.failure(["Invalid email or password"])
    end
  end

  private

  attr_reader :email, :password

  def user
    @user ||= User.active.find_by(email: email.downcase)
  end
end
