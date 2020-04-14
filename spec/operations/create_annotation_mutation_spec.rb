# frozen_string_literal: true

require 'rails_helper'

describe 'Create annotation mutation', :graphql do
  let(:query) do
    <<~'GRAPHQL'
      mutation($input: CreateAnnotationInput!){
        createAnnotation(input: $input) {
          annotation {
            id
            text
            excerpt
          }
          errors {
            field
            message
          }
        }
      }
    GRAPHQL
  end

  it 'can successfully create' do
    user = create(:user)
    create(:verse, id: '1001001')

    annotation_input = {
      verseId: 'verse1001001',
      text: '<p>Lorem <strong>ipsum</strong> dolor <a href="/hello">sit amet</a>, <script src="hello" />consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lectus arcu bibendum at varius. Tellus elementum sagittis vitae et leo duis. Fusce ut placerat orci nulla pellentesque. Fusce id velit ut tortor pretium. Imperdiet proin fermentum leo vel. Leo urna molestie at elementum eu facilisis. Malesuada proin libero nunc consequat interdum. Pulvinar pellentesque habitant morbi tristique senectus. Viverra accumsan in nisl nisi scelerisque eu ultrices vitae auctor. Suscipit adipiscing bibendum est ultricies. Sagittis purus sit amet volutpat. Vel elit scelerisque mauris pellentesque. Vitae elementum curabitur vitae nunc. Facilisis leo vel fringilla est ullamcorper eget nulla facilisi. Et netus et malesuada fames ac.</p>'
    }

    result = execute query, as: user, variables: { input: { annotationInput: annotation_input } }

    annotation = result[:data][:createAnnotation][:annotation]
    # text should strip the script but leave other tags
    expect(annotation[:text]).to eq('<p>Lorem <strong>ipsum</strong> dolor <a href="/hello">sit amet</a>, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lectus arcu bibendum at varius. Tellus elementum sagittis vitae et leo duis. Fusce ut placerat orci nulla pellentesque. Fusce id velit ut tortor pretium. Imperdiet proin fermentum leo vel. Leo urna molestie at elementum eu facilisis. Malesuada proin libero nunc consequat interdum. Pulvinar pellentesque habitant morbi tristique senectus. Viverra accumsan in nisl nisi scelerisque eu ultrices vitae auctor. Suscipit adipiscing bibendum est ultricies. Sagittis purus sit amet volutpat. Vel elit scelerisque mauris pellentesque. Vitae elementum curabitur vitae nunc. Facilisis leo vel fringilla est ullamcorper eget nulla facilisi. Et netus et malesuada fames ac.</p>')
    # excerpt should strip all tags and truncate
    expect(annotation[:excerpt]).to eq('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lectus arcu bibendum at varius. Tellus elementum sagittis vitae et leo duis. Fusce ut placerat orci nulla...')
    expect(Annotation.count).to eq(1)
  end
end
