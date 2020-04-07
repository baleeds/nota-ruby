# frozen_string_literal: true

class AnnotationQuery < Types::BaseResolver
  description 'Get an annotation'
  type Outputs::AnnotationType, null: false
  argument :annotation_id, ID, required: true, loads: Outputs::AnnotationType
  # policy ApplicationPolicy, :logged_in?

  def resolve
    input.annotation
  end
end
