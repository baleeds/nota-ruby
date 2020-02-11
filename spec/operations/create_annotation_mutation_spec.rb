require "rails_helper"

describe "Create annotation mutation", :graphql do
  let(:query) do
    <<~'GRAPHQL'
      mutation($input: CreateAnnotationInput!){
        createAnnotation(input: $input) {
          annotation {
            id
            text
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
    create(:verse, id: "1001001")
          
    annotation_input = {
      verseId: "verse1001001",
      text: "Test",
    }

    result = execute query, as: user, variables: {input: {annotationInput: annotation_input} }

    annotation = result[:data][:createAnnotation][:annotation]
    expect(annotation[:text]).to eq(annotation_input[:text])
    expect(Annotation.count).to eq(1)
  end
end