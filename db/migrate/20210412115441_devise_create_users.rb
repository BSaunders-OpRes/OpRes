class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.references :unit, foreign_key: true, index: true

      t.string   :first_name
      t.string   :last_name
      t.string   :email,              null: false, default: ''
      t.string   :encrypted_password, null: false, default: ''
      t.integer  :role

      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
