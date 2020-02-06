class BookSearch
  attr_reader :term

  def initialize(term:)
    @term = term
  end

  def results
    @results ||= Book.search(term, where: where)
  end

  private

  def where
    {
      lost_at: nil,
      removed_at: nil,
    }
  end
end
