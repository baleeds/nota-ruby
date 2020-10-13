# frozen_string_literal: true

class Annotation < ApplicationRecord
  include Orderable

  validates :text, presence: true
  validates :excerpt, presence: true, length: {maximum: 255, minimum: 10}

  has_many :user_annotation_favorites
  has_many :favorited_by, through: :user_annotation_favorites, source: :user, dependent: :destroy

  belongs_to :user
  belongs_to :verse

  before_validation :sanitize_text
  before_validation :build_excerpt

  scope :favorite_for_user, ->(user) {
    joins(:user_annotation_favorites).where("user_annotation_favorites.user_id = #{user.id}")
  }

  def favorited?(user)
    if !user.present? || !user.respond_to?(:id)
      return false
    end
    
    user_annotation_favorites.any? { |user_annotation_favorite| user_annotation_favorite.user_id == user.id }
  end

  private

  def sanitize_text
    self.text = ActionController::Base.helpers.sanitize(text)
  end

  def build_excerpt
    sanitized_text = ActionController::Base.helpers.sanitize(text, tags: [])
    excerpt = ActionController::Base.helpers.truncate(
        sanitized_text, length: 240, separator: ' '
    )
    self.excerpt = excerpt
  end
end
