class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount, null: false, precision: 20, scale: 2
      t.string :currency, null: false
      t.string :dealer_account_number, null: false
      t.string :dealer_name, null: false
      t.string :reference # kinda why you are tranfering

      t.timestamps
    end
    add_reference :transactions, :account, index: true
    add_foreign_key :transactions, :accounts
  end
end
