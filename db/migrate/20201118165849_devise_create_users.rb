# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|

      ## Database authenticatable (with full name, email and password)
      t.string :firstname,          null: false, default: ""
      t.string :lastname,           null: false, default: ""
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      # phone number will not be used, but it makes Lynx feel real!
      t.string :phone,              null: false, default: ""
      t.datetime :birth_date,       null: false
      t.boolean :is_female
      t.string :postcode
      t.string :address_line_1
      t.string :address_line_2
      t.string :country

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable (cookies)
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip  # to track the scammer

      ## Confirmable (confirmation email?)
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false  # created_at, updated_at
      t.boolean :admin, default: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true

    # Add admin user
    User.create! do |u|
      u.firstname = "Nyx"
      u.lastname = "Random"
      u.email = "zhuoyingjiangli@random.com"
      u.password = "thisisalooooooooooooooongpassword"
      u.birth_date = Date.new(2001, 11, 28)
      u.phone = "+44 07740271205"
      u.is_female = true
      u.postcode = "HAHAHA"
      u.address_line_1 = "1 Strand"
      u.address_line_2 = "London"
      u.country = "GB"
      u.admin = true
    end

  end
end
