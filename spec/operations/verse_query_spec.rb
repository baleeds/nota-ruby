describe "Verse Query", :graphql do
  describe "basic query" do
    query =
      <<-'GRAPHQL'
        query($verseId: ID!) {
          verse(verseId: $verseId) {
            id
          }
        }
      GRAPHQL

    it "returns the specified verse" do
      verse = create(:verse)
      verse_id = "verse" + verse.id

      result = execute query, as: build(:user), variables: {
        verseId: verse_id,
      }

      expect(result[:data][:verse]).to include(id: verse_id)
    end
  end

  describe "numberOfAnnotations field" do
    query =
      <<-'GRAPHQL'
        query($verseId: ID!) {
          verse(verseId: $verseId) {
            id
            numberOfAnnotations
          }
        }
      GRAPHQL

    it "returns the correct number of annotations" do
      verse = create(:verse)
      verse_id = "verse" + verse.id
      create(:annotation, verse: verse)
      create(:annotation, verse: verse)

      result = execute query, as: build(:user), variables: {
        verseId: verse_id
      }

      expect(result[:data][:verse]).to include(numberOfAnnotations: 2)
    end
  end

  describe "numberOfMyAnnotations" do
    query =
      <<-'GRAPHQL'
        query($verseId: ID!) {
          verse(verseId: $verseId) {
            id
            numberOfMyAnnotations
          }
        }
      GRAPHQL

    it "returns the correct number of my annotations" do
      verse = create(:verse)
      verse_id = "verse" + verse.id
      user = create(:user)
      create(:annotation, verse: verse, user: user)
      create(:annotation, verse: verse, user: user)
      create(:annotation, verse: verse)

      result = execute query, as: user, variables: {
        verseId: verse_id
      }

      expect(result[:data][:verse]).to include(numberOfMyAnnotations: 2)
    end
  end
end