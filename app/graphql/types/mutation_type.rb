# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :sign_in_user, resolver: SignInUserMutation
    field :refresh_tokens, resolver: RefreshTokensMutation
    field :update_password, resolver: UpdatePasswordMutation
    field :send_reset_password, resolver: SendResetPasswordMutation
    field :reset_password, resolver: ResetPasswordMutation
    field :suspend_user, resolver: SuspendUserMutation
    field :unsuspend_user, resolver: UnsuspendUserMutation
    field :invalidate_token, resolver: InvalidateTokenMutation
    field :create_user, resolver: CreateUserMutation
    field :create_annotation, resolver: CreateAnnotationMutation
    field :favorite_annotation, resolver: FavoriteAnnotationMutation
    field :unfavorite_annotation, resolver: UnfavoriteAnnotationMutation
  end
end
