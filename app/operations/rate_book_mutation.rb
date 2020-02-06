class RateBookMutation < Types::BaseMutation
  description "Rates a Book"

  argument :book_id, ID, required: true, loads: Outputs::BookType
  argument :rating, Types::BookRatingType, required: true

  field :success, Boolean, null: true
  field :book, Outputs::BookType, null: true
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    user_book_rating = UserBookRating.where(user: current_user, book: input.book).first_or_initialize
    user_book_rating.rating = input.rating

    if user_book_rating.save
      {success: true, book: input.book, errors: []}
    else
      {success: false, errors: user_book_rating.errors}
    end
  end
end
