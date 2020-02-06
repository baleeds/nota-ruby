class Annotation < ApplicationRecord
  include Orderable
  
  validates :text, presence: true
  validates :verse_id, presence: true

  belongs_to :user
end
