# frozen_string_literal: true

module Outputs
  class VerseType < Types::BaseObject
    implements Types::ActiveRecord

    global_id_field :id
    field :number_of_annotations, Integer, null: true
    field :number_of_my_annotations, Integer, null: true
    field :annotations, Outputs::AnnotationType.connection_type, null: false

    def annotations
      Loaders::AssociationLoader.for(Verse, :annotations).load(@object)
    end

    def number_of_annotations
      @object.number_of_annotations
    end

    def number_of_my_annotations
      @object.number_of_annotations_for_user(context[:current_user])
    end

    def self.loads(id)
      Verse.find(id)
    end
  end
end
