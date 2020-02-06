class UserBookRating < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  validates :book_id,
    uniqueness: {scope: :user_id}
  enum rating: {terrible: 1, poor: 2, ok: 3, good: 4, excellent: 5}
end
