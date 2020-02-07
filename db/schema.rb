# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_07_015435) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annotations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "text", null: false
    t.string "verse_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_annotations_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.string "authors"
    t.string "description"
    t.string "image_url"
    t.string "publisher"
    t.string "isbn"
    t.datetime "lost_at"
    t.datetime "removed_at"
    t.integer "page_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "rental_id"
    t.index ["rental_id"], name: "index_books_on_rental_id"
  end

  create_table "favorite_books", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id", "user_id"], name: "index_favorite_books_on_book_id_and_user_id", unique: true
    t.index ["book_id"], name: "index_favorite_books_on_book_id"
    t.index ["user_id"], name: "index_favorite_books_on_user_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.datetime "returned_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_rentals_on_book_id"
    t.index ["user_id"], name: "index_rentals_on_user_id"
  end

  create_table "reset_password_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "body", null: false
    t.boolean "used", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["body"], name: "index_reset_password_tokens_on_body", unique: true
    t.index ["user_id"], name: "index_reset_password_tokens_on_user_id"
  end

  create_table "user_annotation_favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "annotation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["annotation_id", "user_id"], name: "index_user_annotation_favorites_on_annotation_id_and_user_id", unique: true
    t.index ["annotation_id"], name: "index_user_annotation_favorites_on_annotation_id"
    t.index ["user_id"], name: "index_user_annotation_favorites_on_user_id"
  end

  create_table "user_book_ratings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_user_book_ratings_on_book_id"
    t.index ["user_id"], name: "index_user_book_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "active", default: true, null: false
    t.boolean "admin", default: false, null: false
    t.integer "token_version", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "annotations", "users"
  add_foreign_key "books", "rentals"
  add_foreign_key "favorite_books", "books"
  add_foreign_key "favorite_books", "users"
  add_foreign_key "rentals", "books"
  add_foreign_key "rentals", "users"
  add_foreign_key "reset_password_tokens", "users"
  add_foreign_key "user_annotation_favorites", "annotations"
  add_foreign_key "user_annotation_favorites", "users"
  add_foreign_key "user_book_ratings", "books"
  add_foreign_key "user_book_ratings", "users"
end
