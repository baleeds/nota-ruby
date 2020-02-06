module Types
  class BaseResolver < GraphQL::Schema::Resolver
    include Operation
  end
end
