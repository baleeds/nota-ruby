class Verse < ApplicationRecord
  validates :book_number, presence: true
  validates :chapter_number, presence: true
  validates :verse_number, presence: true
  validates :text, presence: true

  has_many :annotations

  def number_of_annotations
    annotations.length
  end

  def number_of_annotations_for_user(user)
    pp user
    if user
      annotations.where(user: user).length
    else
      0
    end
  end
end
