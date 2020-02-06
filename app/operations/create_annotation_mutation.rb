class CreateAnnotationMutation < Types::BaseMutation
  description "Create an annotation"

  argument :annotation_input, Inputs::Annotation, required: true

  field :annotation, Outputs::AnnotationType, null: false
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    annotation = Annotation.new(input.annotation_input.to_h)
    annotation.user = current_user

    if annotation.save
      {annotation: annotation, errors: []}
    else
      {annotation: nil, errors: annotation.errors}
    end
  end
end