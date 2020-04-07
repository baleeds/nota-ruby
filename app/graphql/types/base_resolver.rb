# frozen_string_literal: true

module Types
  class BaseResolver < GraphQL::Schema::Resolver
    include Operation
  end
end
