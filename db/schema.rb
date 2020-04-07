# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_200_207_015_435) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'annotations', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'verse_id', null: false
    t.string 'text', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_annotations_on_user_id'
    t.index ['verse_id'], name: 'index_annotations_on_verse_id'
  end

  create_table 'reset_password_tokens', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'body', null: false
    t.boolean 'used', default: false, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['body'], name: 'index_reset_password_tokens_on_body', unique: true
    t.index ['user_id'], name: 'index_reset_password_tokens_on_user_id'
  end

  create_table 'user_annotation_favorites', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'annotation_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[annotation_id user_id], name: 'index_user_annotation_favorites_on_annotation_id_and_user_id', unique: true
    t.index ['annotation_id'], name: 'index_user_annotation_favorites_on_annotation_id'
    t.index ['user_id'], name: 'index_user_annotation_favorites_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'username', null: false
    t.string 'display_name', null: false
    t.string 'password_digest', null: false
    t.boolean 'active', default: true, null: false
    t.boolean 'admin', default: false, null: false
    t.integer 'token_version', default: 1, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'verses', id: :string, force: :cascade do |t|
    t.string 'text', null: false
    t.integer 'book_number', null: false
    t.integer 'chapter_number', null: false
    t.integer 'verse_number', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'annotations', 'users'
  add_foreign_key 'annotations', 'verses'
  add_foreign_key 'reset_password_tokens', 'users'
  add_foreign_key 'user_annotation_favorites', 'annotations'
  add_foreign_key 'user_annotation_favorites', 'users'
end
