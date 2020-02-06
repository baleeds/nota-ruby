class CreateFavoriteBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_books do |t|
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
      t.index [:book_id, :user_id], unique: true
    end
  end
end
