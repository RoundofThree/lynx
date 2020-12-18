class InsertAccounts < ActiveRecord::Migration[6.0]
  # Create one account in the database
  def change
    Account.create(
      [{
        user_id: 2,
        balance: 1000,
        account_number: "57035847940742",
        cvv: 123,
        expiry_date: Date.new(2021, 10, -1),
        currency: 'GBP'
      },
       {
         user_id: 2,
         balance: 500,
         account_number: "14696478537063",
         cvv: 123,
         expiry_date: Date.new(2021, 10, -1),
         currency: 'GBP'
       },
       {
         user_id: 2,
         balance: 1_000_000,
         account_number: "73042859175930",
         cvv: 123,
         expiry_date: Date.new(2021, 10, -1),
         currency: 'USD'
       }]
    )
  end
end
