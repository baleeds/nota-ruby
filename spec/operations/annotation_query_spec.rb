require "rails_helper"

describe "Annotation query", :graphql do
  context "when valid" do
    query =
      <<-'GRAPHQL'
        query($annotationId: ID!) {
          annotation(annotationId: $annotationId) {
            id
          }
        }
      GRAPHQL

    it "returns the specified annotation" do
      user = create(:user)
      annotation = create(:annotation)
      annotation_id = global_id(annotation, Outputs::AnnotationType)

      result = execute query, as: user, variables: {
        annotationId: annotation_id,
      }

      expect(result[:data][:annotation]).to include(id: annotation_id)
    end
  end
end