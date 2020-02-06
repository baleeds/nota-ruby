class TokenAuthentication
  attr_reader :token_string

  def initialize(token_string:)
    @token_string = token_string
  end

  def authenticate
    decoded_token = AccessToken.decode(token_string)

    if decoded_token.valid?
      decoded_token.user
    else
      Guest.new
    end
  end
end
