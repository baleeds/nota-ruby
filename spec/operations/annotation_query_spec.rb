# frozen_string_literal: true

require 'rails_helper'

describe 'Annotation query', :graphql do
  context 'when valid' do
    query =
      <<-'GRAPHQL'
        query($annotationId: ID!) {
          annotation(annotationId: $annotationId) {
            id
          }
        }
      GRAPHQL

    it 'returns the specified annotation' do
      user = create(:user)
      annotation = create(:annotation)
      annotation_id = global_id(annotation, Outputs::AnnotationType)

      result = execute query, as: user, variables: {
        annotationId: annotation_id
      }

      expect(result[:data][:annotation]).to include(id: annotation_id)
    end
  end

  describe 'favorited field' do
    query =
      <<-'GRAPHQL'
        query($annotationId: ID!) {
          annotation(annotationId: $annotationId) {
            favorited
          }
        }
      GRAPHQL

    it 'is true when favorited by current user' do
      user = create(:user)
      annotation = create(:annotation)
      annotation_id = global_id(annotation, Outputs::AnnotationType)
      favoriteAnnotation = create(:user_annotation_favorite, user: user, annotation: annotation)

      result = execute query, as: user, variables: {
        annotationId: annotation_id
      }

      expect(result[:data][:annotation]).to include(favorited: true)
    end

    it 'is false when not favorited by current user' do
      user = create(:user)
      annotation = create(:annotation)
      annotation_id = global_id(annotation, Outputs::AnnotationType)

      result = execute query, as: user, variables: {
        annotationId: annotation_id
      }

      expect(result[:data][:annotation]).to include(favorited: false)
    end
  end
end
