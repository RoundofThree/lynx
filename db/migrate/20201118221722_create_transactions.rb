class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount, null: false
      t.string :currency, null: false
      t.references :payer_account, null: false
      t.string :payee_account_number, null: false
      t.string :reference

      t.timestamps
    end

    add_foreign_key :transactions, :accounts, column: :payer_account_id
    # add_foreign_key :transactions, :accounts, column: :payee_account_id
  end
end
