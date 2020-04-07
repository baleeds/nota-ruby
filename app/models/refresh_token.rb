# frozen_string_literal: true

class RefreshToken
  ALGORITHM = 'HS256'
  SECRET = Rails.application.credentials[:jwt_refresh_secret]

  def self.issue(user)
    JWT.encode(payload(user), SECRET, ALGORITHM)
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, SECRET, algorithm: ALGORITHM).first
    new(email: decoded_token['email'], version: decoded_token['version'])
  rescue JWT::DecodeError
    new(email: nil, version: 0)
  end

  attr_reader :email, :version

  def initialize(email:, version:, **)
    @email = email
    @version = version
  end

  def user
    @user ||= User.active.find_by(email: email)
  end

  def valid?
    user&.token_version == version
  end

  class << self
    private

    def payload(user)
      {
        email: user.email,
        exp: expiration,
        version: user.token_version
      }
    end

    def expiration
      7.days.from_now.to_i
    end
  end
end
