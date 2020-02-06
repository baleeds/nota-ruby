module BookGateway
  module Http
    module_function

    def find_by_isbn(isbn)
      result = GoogleBooks.search(prepend_isbn(isbn))

      result&.first
    end

    private

    module_function

    def prepend_isbn(isbn)
      "isbn:#{isbn}"
    end
  end
end
