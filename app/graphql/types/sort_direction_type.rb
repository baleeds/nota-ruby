module Types
  class SortDirectionType < Types::BaseEnum
    graphql_name "SortDirectionType"
    description "The direction to sort results"
    value "ASC", value: :asc
    value "DESC", value: :desc
  end
end
