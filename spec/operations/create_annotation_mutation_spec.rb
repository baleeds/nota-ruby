require "rails_helper"

describe "Create annotation mutation", :graphql do
  let(:query) do
    <<~'GRAPHQL'
      mutation($input: CreateAnnotationInput!){
        createAnnotation(input: $input) {
          annotation {
            id
            text
            verseId
          }
          errors {
            field
            message
          }
        }
      }
    GRAPHQL
  end

  it "can successfully create" do
    user = create(:user)
          
    annotation_input = {
      verseId: "01001001",
      text: "Test",
    }

    result = execute query, as: user, variables: {input: {annotationInput: annotation_input} }

    annotation = result[:data][:createAnnotation][:annotation]
    expect(annotation[:verseId]).to eq(annotation_input[:verseId])
    expect(annotation[:text]).to eq(annotation_input[:text])
    expect(Annotation.count).to eq(1)
  end
end