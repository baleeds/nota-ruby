class SearchBooksQuery < Types::BaseResolver
  description "Gets all the books"
  argument :term, String, "The search term to look for books", required: true
  type [Outputs::BookType], null: false
  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    BookSearch.new(term: input.term).results
  end
end
