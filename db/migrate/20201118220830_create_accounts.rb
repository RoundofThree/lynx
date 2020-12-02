class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :balance
      t.string :account_number
      t.string :cvv
      t.datetime :expiry_date
      t.string :currency

      t.timestamps
    end
  end
end
