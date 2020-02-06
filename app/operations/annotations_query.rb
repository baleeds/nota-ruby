class AnnotationsQuery < Types::BaseResolver
  description "Gets all public annotations"
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
  # policy ApplicationPolicy, :logged_in?

  def resolve
    pp current_user
    if current_user.guest?
      Annotation.all
    else
      Annotation.where.not(user: current_user)
    end
  end
end
