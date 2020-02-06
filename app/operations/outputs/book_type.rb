module Outputs
  class BookType < Types::BaseObject
    implements Types::ActiveRecord

    global_id_field :id
    field :title, String, null: false
    field :authors, String, null: true
    field :description, String, null: true
    field :image_url, String, null: true
    field :publisher, String, null: true
    field :page_count, Integer, null: true
    field :average_rating, Float, null: true
    field :is_favorited_by_me, Boolean, null: true
    field :my_rating, Integer, null: true
    field :currently_checked_out, Boolean, null: false
    field :rental, RentalType, null: true
    field :is_currently_checked_out, Boolean, null: false
    field :is_currently_checked_out_by_me, Boolean, null: false
    field :is_lost_or_removed, Boolean, null: false

    def is_lost_or_removed
      !@object.active
    end

    def average_rating
      Loaders::AssociationLoader.for(Book, :user_book_ratings).load(@object).then do
        @object.average_rating
      end
    end

    def is_favorited_by_me
      Loaders::AssociationLoader.for(Book, :favorite_books).load(@object).then do
        @object.favorited?(context[:current_user])
      end
    end

    def my_rating
      Loaders::AssociationLoader.for(Book, :user_book_ratings).load(@object).then do
        @object.rating_for_user(context[:current_user])
      end
    end

    def is_currently_checked_out
      Loaders::AssociationLoader.for(Book, :active_rentals).load(@object).then do
        @object.currently_checked_out?
      end
    end

    def rental
      return nil unless context[:current_user].admin?
      Loaders::AssociationLoader.for(Book, :active_rentals).load(@object).then do
        @object.latest_rental
      end
    end

    def is_currently_checked_out_by_me
      Loaders::AssociationLoader.for(Book, :active_rentals).load(@object).then do
        @object.currently_checked_out_by_user?(context[:current_user])
      end
    end

    def self.loads(id)
      Book.find(id)
    end
  end
end
