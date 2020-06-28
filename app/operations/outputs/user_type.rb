# frozen_string_literal: true

module Outputs
  class UserType < Types::BaseObject
    implements Types::ActiveRecord

    global_id_field :id
    field :email, String, null: false
    field :is_active, Boolean, null: false
    field :is_admin, Boolean, null: false
    field :username, String, null: false
    field :display_name, String, null: false
    field :annotations, Outputs::AnnotationType.connection_type, null: true
    field :favorite_annotations, Outputs::AnnotationType.connection_type, null: true

    def self.loads(id)
      User.find(id)
    end

    def annotations
      Loaders::AssociationLoader.for(User, :annotations).load(@object)
    end

    def favorite_annotations
      Annotation.favorite_for_user(@object)
    end

    def is_active
      @object.active?
    end

    def is_admin
      @object.admin?
    end
  end
end
