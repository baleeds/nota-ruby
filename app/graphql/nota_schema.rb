class NotaSchema < GraphQL::Schema
  use GraphQL::Batch

  mutation(Types::MutationType)
  query(Types::QueryType)

  class << self
    def id_from_object(object, type_definition, query_ctx)
      GraphQL::Schema::UniqueWithinType.encode(type_definition.name, object.id)
    end

    def object_from_id(id, query_ctx)
      return record_not_found_error if id.empty?

      type_name, item_id = decode_global_id(id)
      "Outputs::#{type_name}Type".constantize.loads(item_id)
    rescue ::ActiveRecord::RecordNotFound
      record_not_found_error
    end

    def record_not_found_error
      execution_error("Couldn't find record", "NOT_FOUND")
    end

    def authenticated_error
      execution_error("You must be authenticated to perform this action", "UNAUTHENTICATED")
    end

    def authorized_error
      execution_error("You don't have permission to perform this action", "UNAUTHORIZED")
    end

    private

    def decode_global_id(id)
      GraphQL::Schema::UniqueWithinType.decode(id)
    rescue ArgumentError
      execution_error("Invalid global id provided", "NOT_FOUND")
    end

    def execution_error(message, code)
      raise GraphQL::ExecutionError.new(message, extensions: {code: code})
    end
  end
end
