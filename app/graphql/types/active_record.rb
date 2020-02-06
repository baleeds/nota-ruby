require "graphql/types/iso_8601_date_time"

module Types
  module ActiveRecord
    include Types::BaseInterface

    field :created_at,
      GraphQL::Types::ISO8601DateTime,
      description: "The date and time when then record was created",
      null: false
    field :updated_at,
      GraphQL::Types::ISO8601DateTime,
      description: "The date and time the record was last updated",
      null: false
  end
end
