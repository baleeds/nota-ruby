module Inputs
  class Book < Types::BaseInputObject
    graphql_name "BookInput"
    description "Properties for a Book"
    argument :title, String, required: false
    argument :authors, String, required: false
    argument :description, String, required: false
    argument :image_url, String, required: false
    argument :publisher, String, required: false
    argument :page_count, Integer, required: false
  end
end
