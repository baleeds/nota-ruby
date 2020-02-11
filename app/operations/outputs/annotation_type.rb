module Outputs
  class AnnotationType < Types::BaseObject
    implements Types::ActiveRecord

    global_id_field :id
    field :text, String, null: false
    field :user, Outputs::UserType, null: false
    field :favorited, Boolean, null: false

    def user
      Loaders::AssociationLoader.for(Annotation, :user).load(@object)
    end

    def favorited
      Loaders::AssociationLoader.for(Annotation, :user_annotation_favorites).load(@object).then do
        @object.favorited?(context[:current_user])
      end
    end

    def self.loads(id)
      Annotation.find(id)
    end
  end
end