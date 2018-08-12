# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.string   :name, default: '', null: false
      t.string   :message, default: '', null: false
      t.string   :message4payment, default: '', null: false # message for payment and delivery (for distributor)
      t.integer  :gender, default: 0, null: false
      t.string   :tel,  default: '', null: false
      t.string   :line_id, default: '', null: false
      t.string   :facebook_id, default: '', null: false
      t.string   :postal, default: '', null: false
      t.string   :prefecture, default: '', null: false
      t.string   :address, default: '', null: false
      t.string   :street, default: '', null: false
      t.integer  :parent_user_id, default: 1, null: true # distributor's id

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
