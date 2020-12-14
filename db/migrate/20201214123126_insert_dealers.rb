class InsertDealers < ActiveRecord::Migration[6.0]
  def change
    Dealer.create!(
      [{
        currency: "GBP",
        name: "KFC dev",
        account_number: "00001000010001",
        min_amount: 2,
        max_amount: 30,
        frequency: 10
      },
      {
        currency: "GBP",
        name: "McDonald's dev",
        account_number: "00001000010002",
        min_amount: 2,
        max_amount: 20,
        frequency: 5
      }, 
      {
        currency: "GBP",
        name: "PC World dev",
        account_number: "00001000010003",
        min_amount: 50,
        max_amount: 2000,
        frequency: 1
      },
      {
        currency: "USD",
        name: "Taco Bell dev",
        account_number: "00001000010004",
        min_amount: 4,
        max_amount: 30,
        frequency: 6
      }]
    )
  end
end
