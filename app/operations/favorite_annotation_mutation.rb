class FavoriteAnnotationMutation < Types::BaseMutation
  description "Favorites an annotation"

  argument :annotation_id, ID, required: true, loads: Outputs::AnnotationType

  field :success, Boolean, null: true
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    favorite_annotation = UserAnnotationFavorite.new(user: current_user, annotation: input.annotation)

    if favorite_annotation.save
      {success: true, errors: []}
    else
      {success: false, errors: favorite_annotation.errors}
    end
  end
end
