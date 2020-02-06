module Types
  class ErrorType < Types::BaseObject
    field :field, String, "The field the error relates to", null: false
    field :message, String, "The error message", null: false
  end
end
