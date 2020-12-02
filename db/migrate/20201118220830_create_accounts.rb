class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      # the balance should always have 2 decimal places
      t.decimal :balance, precision: 20, scale: 2 
      t.string :account_number
      t.string :cvv
      t.datetime :expiry_date
      t.string :currency

      t.timestamps
    end
  end
end
