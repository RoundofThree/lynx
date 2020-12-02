class InsertAccounts < ActiveRecord::Migration[6.0]
  # Create one account in the database
  def change
    Account.create(
      [{
        user_id: 1,
        balance: 1000,
        account_number: 12345678,
        cvv: 123,
        expiry_date: DateTime.new(2024, 10, -1),
        currency: 'GBP'
      },
      {
        user_id: 1,
        balance: 500,
        account_number: 11111111,
        cvv: 123,
        expiry_date: DateTime.new(2024, 10, -1),
        currency: 'CNY'
      },
      {
        user_id: 1,
        balance: 1000000,
        account_number: 88888888,
        cvv: 123,
        expiry_date: DateTime.new(2024, 10, -1),
        currency: 'USD'
      }]
    )
  end
end
