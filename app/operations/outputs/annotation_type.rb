module Outputs
  class AnnotationType < Types::BaseObject
    implements Types::ActiveRecord

    global_id_field :id
    field :text, String, null: false
    field :verse_id, String, null: false
    field :user, Outputs::UserType, null: false

    def checked_out_by
      Loaders::AssociationLoader.for(Annotation, :user).load(@object)
    end

    def self.loads(id)
      Annotation.find(id)
    end
  end
end