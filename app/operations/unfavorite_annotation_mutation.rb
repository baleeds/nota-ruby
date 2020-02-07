class UnfavoriteAnnotationMutation < Types::BaseMutation
  description "Unfavorites an annotation"

  argument :annotation_id, ID, required: true, loads: Outputs::AnnotationType

  field :success, Boolean, null: true
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    user_annotation_favorite = UserAnnotationFavorite.find_by!(user: current_user, annotation: input.annotation)
    user_annotation_favorite.destroy

    {success: user_annotation_favorite.destroyed?, errors: user_annotation_favorite.errors}
  end
end
