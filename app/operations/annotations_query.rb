class AnnotationsQuery < Types::BaseResolver
  description "Gets all public annotations"
  argument :verse_id, ID, required: true, loads: Outputs::VerseType

  # argument :sort_by,
  #   Types::BookSortByType,
  #   "The column to sort the results by",
  #   default_value: :title,
  #   required: false
  # argument :sort_direction,
  #   Types::SortDirectionType,
  #   "The direction to sort the results",
  #   default_value: :asc,
  #   required: false

  type Outputs::AnnotationType.connection_type, null: false

  def resolve
    annotations = Annotation.where(verse: input.verse)
    annotations = annotations.where.not(user: current_user) if !current_user.guest?
    annotations
  end
end
