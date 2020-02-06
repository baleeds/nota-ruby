module Types
  class BookRatingType < Types::BaseEnum
    description "A description of a books quality"
    value "TERRIBLE", value: :terrible
    value "POOR", value: :poor
    value "OK", value: :ok
    value "GOOD", value: :good
    value "EXCELLENT", value: :excellent
  end
end
