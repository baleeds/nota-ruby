class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :authors
      t.string :description
      t.string :image_url
      t.string :publisher
      t.string :isbn

      t.datetime :lost_at
      t.datetime :removed_at

      t.integer :page_count

      t.timestamps
    end
  end
end
