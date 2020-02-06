class CreateResetPasswordTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :reset_password_tokens do |t|
      t.references :user, foreign_key: true, null: false
      t.string :body, null: false
      t.boolean :used, default: false, null: false

      t.timestamps
      t.index :body, unique: true
    end
  end
end
