# frozen_string_literal: true

# Returns annotations
class AnnotationsQuery < Types::BaseResolver
  description 'Gets all public annotations'
  argument :verse_id, ID, required: false, loads: Outputs::VerseType

  type Outputs::AnnotationType.connection_type, null: false

  def resolve
    annotations = Annotation.all

    annotations = annotations.where(verse: input.verse) if input.verse.present?

    unless current_user.guest?
      annotations = annotations.where.not(user: current_user)
    end

    annotations
  end
end
