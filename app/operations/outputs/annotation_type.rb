module Outputs
  class AnnotationType < Types::BaseObject
    implements Types::ActiveRecord

    global_id_field :id
    field :text, String, null: false

    def self.loads(id)
      User.find(id)
    end
  end
end