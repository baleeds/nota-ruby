# frozen_string_literal: true

class SendResetPasswordMutation < Types::BaseMutation
  description 'Triggers a reset password email'

  argument :email, String, required: true

  field :success, Boolean, null: false

  def resolve
    result = CreateResetPasswordToken.new(user).call

    if result.success?
      { success: true }
    else
      { success: false }
    end
  end

  private

  def user
    User.find_by!(email: input.email)
  end
end
