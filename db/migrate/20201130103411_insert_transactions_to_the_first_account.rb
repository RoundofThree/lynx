class InsertTransactionsToTheFirstAccount < ActiveRecord::Migration[6.0]
  def change
    Transaction.create(
      [{
        payer_account_id: 1,
        amount: 1000,
        currency: "GBP",
        payee_account_number: "31415926",
        payee_fullname: "My Payee",
        reference: 'My first Transaction'
      },
      {
        payer_account_id: 1,
        amount: 90.9,
        currency: "GBP",
        payee_account_number: "31415926",
        payee_fullname: "My Payee",
        reference: 'My second Transaction'
      },
      {
        payer_account_id: 1,
        amount: 1111.11,
        currency: "GBP",
        payee_account_number: "31415926",
        payee_fullname: "My Payee",
        reference: 'My third Transaction'
      }]
    )
  end
end
