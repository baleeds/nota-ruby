# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :username, null: false
      t.string :display_name, null: false
      t.string :password_digest, null: false
      t.boolean :active, default: true, null: false
      t.boolean :admin, default: false, null: false
      t.integer :token_version, default: 1, null: false

      t.timestamps
    end
  end
end
