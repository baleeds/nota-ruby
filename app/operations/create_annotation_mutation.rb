# frozen_string_literal: true

class CreateAnnotationMutation < Types::BaseMutation
  include ActionView::Helpers

  description 'Create an annotation'

  argument :annotation_input, Inputs::Annotation, required: true

  field :annotation, Outputs::AnnotationType, null: false
  field :errors, function: Resolvers::Error.new

  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    annotation = Annotation.new(input.annotation_input.to_h)

    annotation.text = sanitize_text(annotation.text)
    annotation.excerpt = get_excerpt(annotation.text)
    annotation.user = current_user

    if annotation.save
      { annotation: annotation, errors: [] }
    else
      { annotation: nil, errors: annotation.errors }
    end
  end

  private

  def sanitize_text(text)
    sanitize(text)
  end

  def get_excerpt(text)
    sanitized_text = sanitize(text, tags: [])
    excerpt = truncate(
      sanitized_text, length: 240, separator: ' '
    )
    excerpt
  end
end
