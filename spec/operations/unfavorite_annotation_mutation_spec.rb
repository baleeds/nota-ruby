# frozen_string_literal: true

require 'rails_helper'

describe 'Unfavorite annotation mutation', :graphql do
  let(:query) do
    <<~'GRAPHQL'
      mutation($input: UnfavoriteAnnotationInput!) {
        unfavoriteAnnotation(input: $input) {
          success
          errors {
            field
            message
          }
        }
      }
    GRAPHQL
  end

  it 'allows a user to unfavorite a annotation' do
    user_annotation_favorite = create(:user_annotation_favorite)
    input = { annotationId: global_id(user_annotation_favorite.annotation, Outputs::AnnotationType) }

    result = execute query, as: user_annotation_favorite.user, variables: { input: input }

    success = result[:data][:unfavoriteAnnotation][:success]
    expect(success).to be(true)
  end
end
