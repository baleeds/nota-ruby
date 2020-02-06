module Types
  class QueryType < Types::BaseObject
    field :books, resolver: BooksQuery
    field :book, resolver: BookQuery
    field :users, resolver: UsersQuery
    field :user, resolver: UserQuery
    field :me, resolver: MeQuery
    field :search_books, resolver: SearchBooksQuery
    field :checked_out_books, resolver: AdminCheckedOutBooksQuery
    field :my_checkout_history, resolver: MyCheckoutHistoryQuery
    field :my_checked_out_books, resolver: MyCheckedOutBooksQuery
    field :my_favorite_books, resolver: MyFavoriteBooksQuery
    field :annotation, resolver: AnnotationQuery
    field :annotations, resolver: AnnotationsQuery
    field :my_annotations, resolver: MyAnnotationsQuery
  end
end
