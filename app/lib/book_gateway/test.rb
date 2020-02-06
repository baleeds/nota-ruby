module BookGateway
  module Test
    module_function

    def find_by_isbn(isbn)
      fake_book = OpenStruct.new({
        title: "The Great Gatsby",
        authors: "F. Scott Fitzgerald",
        publisher: "Simon and Schuster",
        page_count: 165,
        image_link: image_link,
        description: description,
      })

      return fake_book unless isbn.nil?
    end

    private

    module_function

    def image_link
      "http://books.google.com/books/content?id=iXn5U2IzVH0C&printsec=frontcover&img=1&zoom=1&edge=none&source=gbs_api"
    end

    def description
      <<-'DESCRIPTION'
        "A true classic of twentieth-century literature, this edition has been updated by
         Fitzgerald scholar James L.W. West III to include the author’s final revisions
         and features a note on the composition and text, a personal foreword by Fitzgerald’s
         granddaughter, Eleanor Lanahan—and a new introduction by two-time National Book Award
         winner Jesmyn Ward. Nominated as one of America’s best-loved novels by PBS’s The Great American Read..."
      DESCRIPTION
    end
  end
end
