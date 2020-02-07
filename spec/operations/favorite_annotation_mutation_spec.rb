require "rails_helper"

describe "Favorite annotation mutation", :graphql do
  let(:query) do
    <<~'GRAPHQL'
      mutation($input: FavoriteAnnotationInput!) {
        favoriteAnnotation(input: $input) {
          success
          errors {
            field
            message
          }
        }
      }
    GRAPHQL
  end

  it "succeeds with valid input" do
    annotation = create(:annotation)
    user = create(:user)

    input = {
      annotationId: global_id(annotation, Outputs::AnnotationType),
    }

    result = execute query, as: user, variables: {input: input}

    success = result[:data][:favoriteAnnotation][:success]
    expect(success).to be(true)
  end
end
