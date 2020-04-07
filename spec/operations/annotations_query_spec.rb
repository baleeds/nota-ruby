# frozen_string_literal: true

require 'rails_helper'

describe 'Annotations query', :graphql do
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

  it 'excludes private annotations for logged in user' do
    verse = create(:verse)
    me = create(:user)
    not_me = create(:user)
    annotation = create(:annotation, verse: verse, user: me)
    annotation_id = global_id(annotation, Outputs::AnnotationType)
    public_annotation = create(:annotation, verse: verse, user: not_me)
    public_annotation_id = global_id(public_annotation, Outputs::AnnotationType)

    result = execute query, as: me, variables: {
      verse_id: 'verse1001001'
    }

    annotations_result = result[:data][:annotations][:edges].pluck(:node)
    expect(annotations_result).not_to include(id: annotation_id)
    expect(annotations_result).to include(id: public_annotation_id)
  end
end
