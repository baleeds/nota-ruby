class VerseQuery < Types::BaseResolver
  description "Get an annotation"
  type Outputs::VerseType, null: false
  argument :verse_id, ID, required: true, loads: Outputs::VerseType

  def resolve
    input.verse
  end
end
