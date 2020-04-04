class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, length: {minimum: 8}, allow_nil: true
  validates :username, presence: true, uniqueness: true
  validates :display_name, presence: true

  has_many :annotations

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
