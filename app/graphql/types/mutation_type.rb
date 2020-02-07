module Types
  class MutationType < Types::BaseObject
    field :sign_in_user, resolver: SignInUserMutation
    field :refresh_tokens, resolver: RefreshTokensMutation
    field :update_password, resolver: UpdatePasswordMutation
    field :send_reset_password, resolver: SendResetPasswordMutation
    field :reset_password, resolver: ResetPasswordMutation
    field :suspend_user, resolver: SuspendUserMutation
    field :unsuspend_user, resolver: UnsuspendUserMutation
    field :add_book_by_isbn, resolver: AddBookByIsbnMutation
    field :add_book_manually, resolver: AddBookManuallyMutation
    field :update_book, resolver: UpdateBookMutation
    field :favorite_book, resolver: FavoriteBookMutation
    field :rate_book, resolver: RateBookMutation
    field :checkout_book, resolver: CheckoutBookMutation
    field :return_book, resolver: ReturnBookMutation
    field :remove_book, resolver: RemoveBookMutation
    field :lost_book, resolver: LostBookMutation
    field :unfavorite_book, resolver: UnfavoriteBookMutation
    field :invalidate_token, resolver: InvalidateTokenMutation
    field :create_user, resolver: CreateUserMutation
    field :create_annotation, resolver: CreateAnnotationMutation
    field :favorite_annotation, resolver: FavoriteAnnotationMutation
  end
end
