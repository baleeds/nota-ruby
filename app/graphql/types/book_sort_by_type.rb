module Types
  class BookSortByType < Types::BaseEnum
    graphql_name "BookSortByType"
    description "Possible columns to sort books by"
    value "TITLE", value: :title
    value "AUTHORS", value: :authors
    value "CREATED_AT", value: :created_at
  end
end
