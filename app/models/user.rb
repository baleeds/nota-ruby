class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, length: {minimum: 8}, allow_nil: true

  has_many :favorite_books
  has_many :favorites, through: :favorite_books, source: :book, dependent: :destroy

  has_secure_password

  scope :active, -> { where(active: true) }

  def update_password(current:, new:)
    if authenticate(current)
      update(password: new)
    else
      false
    end
  end

  def suspend
    update(active: false)
  end

  def unsuspend
    update(active: true)
  end

  def guest?
    false
  end
end
