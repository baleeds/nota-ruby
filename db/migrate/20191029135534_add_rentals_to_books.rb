class AddRentalsToBooks < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :rental, null: true, foreign_key: true
  end
end
