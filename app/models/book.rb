class Book < ApplicationRecord
  include Orderable
  searchkick callbacks: :async, word_start: [:title, :author, :description]

  validates :title, presence: true

  has_many :favorite_books
  has_many :favorited_by, through: :favorite_books, source: :user, dependent: :destroy
  has_many :user_book_ratings
  has_many :rentals
  has_many :active_rentals, -> { active }, class_name: "Rental"

  scope :active, -> { where(lost_at: nil, removed_at: nil) }
  scope :checked_out, -> { active.joins(:rentals).merge(Rental.active) }
  scope :latest_checked_out, -> { active.joins(:rentals).merge(Rental.latest).checked_out }
  scope :favorite_for_user, ->(user) { joins(:favorite_books).where("favorite_books.user_id = #{user.id}") }

  def average_rating
    ratings_count = user_book_ratings.length
    return nil if ratings_count.zero?

    ratings_sum = user_book_ratings.sum { |rating| UserBookRating.ratings[rating.rating] }

    ratings_sum / ratings_count
  end

  def rating_for_user(user)
    user_book_rating = user_book_ratings.find { |rating| rating.user_id === user.id }
    if user_book_rating
      UserBookRating.ratings[user_book_rating.rating]
    end
  end

  def lost?
    !lost_at.nil?
  end

  def removed?
    !removed_at.nil?
  end

  def checked_out?
    rentals.active.any?
  end

  def currently_checked_out?
    active_rentals.any?
  end

  def latest_rental
    active_rentals.order("created_at DESC").first
  end

  def currently_checked_out_by_user?(user)
    active_rentals.any? { |rental| rental.user_id == user.id }
  end

  def favorited?(user)
    favorite_books.any? { |favorite_book| favorite_book.user_id == user.id }
  end
end
