# frozen_string_literal: true

module Inputs
  class Annotation < Types::BaseInputObject
    graphql_name 'AnnotationInput'
    description 'Properties for an annotation'
    argument :text, String, required: true
    # argument :excerpt, String, required: true
    argument :verse_id, ID, required: true, loads: Outputs::VerseType
  end
end
