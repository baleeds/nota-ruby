# frozen_string_literal: true

class CreateUserAnnotationFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :user_annotation_favorites do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :annotation, null: false, foreign_key: true

      t.timestamps
      t.index %i[annotation_id user_id], unique: true
    end
  end
end
