class CreateUserBookRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :user_book_ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
