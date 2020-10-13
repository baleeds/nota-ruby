class FavoriteAnnotationsQuery < Types::BaseResolver
  description 'Gets all favorite annotations for user'
  
  argument :user_id, ID, required: true
  
  type Outputs::AnnotationType.connection_type, null: false

  def resolve(user_id: nil)
    Annotation.favorite_for_user(User.new(id: user_id))
  end
end
