class UserAnnotationFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :annotation

  validates :annotation_id,
    uniqueness: {scope: :user_id}
end
