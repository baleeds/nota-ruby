# frozen_string_literal: true

require 'rails_helper'

describe 'Annotations query', :graphql do
  describe 'when valid' do
    let(:query) do
      <<-'GRAPHQL'
        query {
          annotations {
            edges {
              node {
                id
              }
            }
          }
        }
      GRAPHQL
    end

    it 'returns a list of all annotations' do
      # user = create(:user, email: "test@test.com")
      annotation = create(:annotation)
      annotation_id = global_id(annotation, Outputs::AnnotationType)

      result = execute query

      annotations_result = result[:data][:annotations][:edges].pluck(:node)
      expect(annotations_result).to include(id: annotation_id)
    end

    it 'returns annotations for a verse' do
      create(:verse, id: '01001001')
      verse = create(:verse, id: '01001002')
      annotation = create(:annotation, verse: verse)
      annotation_id = global_id(annotation, Outputs::AnnotationType)

      result = execute query, variables: {
        verse_id: 'verse1001001'
      }

      annotations_result = result[:data][:annotations][:edges].pluck(:node)
      expect(annotations_result).to include(id: annotation_id)
    end
  end
end
