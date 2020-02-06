class CreateAnnotations < ActiveRecord::Migration[6.0]
  def change
    create_table :annotations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :text, null: false
      t.string :verse_id, null: false

      t.timestamps
    end
  end
end
