class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount, null: false, precision: 20, scale: 2
      t.string :currency, null: false
      # t.references :account, null: false, foreign_key: true
      t.string :dealer_account_number, null: false
      t.string :dealer_name, null: false
      t.string :reference # kinda why you are tranfering

      t.timestamps
    end
    add_reference :transactions, :account, index: true
    add_foreign_key :transactions, :accounts

    # add_foreign_key :transactions, :accounts, column: :payer_account_id
    # add_foreign_key :transactions, :accounts, column: :payee_account_id
  end
end
