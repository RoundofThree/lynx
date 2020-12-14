class InsertAccounts < ActiveRecord::Migration[6.0]
  # Create one account in the database
  def change
    Account.create(
      [{
        user_id: 1,
        balance: 1000,
        account_number: 12_345_678,
        cvv: 123,
        expiry_date: Date.new(2021, 10, -1),
        currency: 'GBP'
      },
       {
         user_id: 1,
         balance: 500,
         account_number: 11_111_111,
         cvv: 123,
         expiry_date: Date.new(2021, 10, -1),
         currency: 'GBP'
       },
       {
         user_id: 1,
         balance: 1_000_000,
         account_number: 88_888_888,
         cvv: 123,
         expiry_date: Date.new(2021, 10, -1),
         currency: 'USD'
       }]
    )
  end
end
