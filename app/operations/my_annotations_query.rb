class MyAnnotationsQuery < Types::BaseResolver
  description "Gets all of my annotations"

  type Outputs::AnnotationType.connection_type, null: false

  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    Annotation.where(user: current_user)
  end
end
