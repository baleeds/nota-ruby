class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :latest, -> { order("created_at DESC") }
  scope :active, -> { where(returned_at: nil) }
  scope :for_user, ->(user) { where(user: user) }
end
