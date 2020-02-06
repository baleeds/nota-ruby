module Types
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    include Operation

    def self.graphql_name
      super.chomp("Mutation")
    end
  end
end
