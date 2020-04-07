# frozen_string_literal: true

# Returns annotations
class AnnotationsQuery < Types::BaseResolver
  description 'Gets all public annotations'
  argument :verse_id, ID, required: false, loads: Outputs::VerseType
  argument :user_id, ID, required: false, loads: Outputs::UserType

  type Outputs::AnnotationType.connection_type, null: false

  def resolve
    annotations = Annotation.all
    annotations = annotations.where(verse: input.verse) if input.verse.present?
    annotations = filter_by_user(annotations)

    annotations
  end

  private

  def filter_by_user(annotations)
    if input.user.present?
      annotations.where(user: input.user)
    elsif !current_user.guest?
      annotations.where.not(user: current_user)
    else
      annotations
    end
  end
end
