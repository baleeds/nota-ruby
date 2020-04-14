# frozen_string_literal: true

class CreateAnnotations < ActiveRecord::Migration[6.0]
  def change
    create_table :annotations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :verse, null: false, foreign_key: true, type: :string
      t.text :text, null: false
      t.text :excerpt, null: false

      t.timestamps
    end
  end
end
