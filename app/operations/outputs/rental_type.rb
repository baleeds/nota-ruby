module Outputs
  class RentalType < Types::BaseObject
    implements Types::ActiveRecord

    global_id_field :id
    field :checked_out_at, GraphQL::Types::ISO8601DateTime, null: false
    field :book, Outputs::BookType, null: false
    field :returned_at, GraphQL::Types::ISO8601DateTime, null: true
    field :checked_out_by, Outputs::UserType, null: false

    def checked_out_at
      @object.created_at
    end

    def checked_out_by
      Loaders::AssociationLoader.for(Rental, :user).load(@object)
    end

    def book
      Loaders::AssociationLoader.for(Rental, :book).load(@object)
    end
  end
end
