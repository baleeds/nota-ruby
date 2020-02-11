class Annotation < ApplicationRecord
  include Orderable
  
  validates :text, presence: true

  has_many :user_annotation_favorites
  has_many :favorited_by, through: :user_annotation_favorites, source: :user, dependent: :destroy

  belongs_to :user
  belongs_to :verse

  scope :favorite_for_user, ->(user) { joins(:user_annotation_favorites).where("user_annotation_favorites.user_id = #{user.id}") }

  def favorited?(user)
    user_annotation_favorites.any? { |user_annotation_favorite| user_annotation_favorite.user_id == user.id }
  end
end
