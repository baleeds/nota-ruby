class Annotation < ApplicationRecord
  include Orderable
  
  validates :text, presence: true
end
