# frozen_string_literal: true

module Outputs
  class AnnotationType < Types::BaseObject
    implements Types::ActiveRecord

    global_id_field :id
    field :text, String, null: false
    field :excerpt, String, null: false
    field :favorited, Boolean, null: false
    field :user, Outputs::UserType, null: false
    field :verse, Outputs::VerseType, null: false

    def user
      Loaders::AssociationLoader.for(Annotation, :user).load(@object)
    end

    def verse
      Loaders::AssociationLoader.for(Annotation, :verse).load(@object)
    end

    # TODO: this might be really nasty.  Pretty sure this loads all favorites and loops over them to
    # determine if the current user is in the list...
    def favorited
      pp @object
      
      Loaders::AssociationLoader.for(Annotation, :user_annotation_favorites).load(@object).then do
        @object.favorited?(context[:current_user])
      end
    end

    def self.loads(id)
      Annotation.find(id)
    end
  end
end
