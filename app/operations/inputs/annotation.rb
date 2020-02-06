module Inputs
  class Annotation < Types::BaseInputObject
    graphql_name "AnnotationInput"
    description "Properties for an annotation"
    argument :text, String, required: true
    argument :verse_id, String, required: true
  end
end
