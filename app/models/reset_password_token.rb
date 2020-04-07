# frozen_string_literal: true

class ResetPasswordToken < ApplicationRecord
  belongs_to :user

  validates :body, uniqueness: true

  has_secure_token :body

  scope :active, -> { where('created_at >= ?', max_age).where(used: false) }

  def self.max_age
    1.day.ago
  end

  def self.find_active(body)
    active.find_by(body: body)
  end

  def use
    update(used: true)
  end
end
