# frozen_string_literal: true

class AccessToken
  ALGORITHM = 'HS256'
  SECRET = Rails.application.credentials[:jwt_access_secret]

  def self.issue(user)
    JWT.encode(payload(user), SECRET, ALGORITHM)
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, SECRET, algorithm: ALGORITHM).first
    new(email: decoded_token['email'])
  rescue JWT::DecodeError
    new(email: nil)
  end

  attr_reader :email

  def initialize(email:, **)
    @email = email
  end

  def user
    @user ||= User.active.find_by(email: email)
  end

  def valid?
    user.present?
  end

  class << self
    private

    def payload(user)
      {
        email: user.email,
        exp: expiration
      }
    end

    def expiration
      24.hours.from_now.to_i
    end
  end
end
