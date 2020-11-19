class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :balance
      t.string :account_number
      t.string :cvv
      t.integer :expiry_month
      t.integer :expiry_year
      t.string :currency
      t.boolean :frozen, default: false 

      t.timestamps
    end
  end
end
