class CreateVerses < ActiveRecord::Migration[6.0]
  def change
    create_table :verses, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :text, null: false
      t.integer :book_number, null: false
      t.integer :chapter_number, null: false
      t.integer :verse_number, null: false

      t.timestamps
    end
  end
end
