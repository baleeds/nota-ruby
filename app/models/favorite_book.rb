class FavoriteBook < ApplicationRecord
  belongs_to :book
  belongs_to :user
  validates :book_id,
    uniqueness: {scope: :user_id}
end
