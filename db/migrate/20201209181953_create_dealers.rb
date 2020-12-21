class CreateDealers < ActiveRecord::Migration[6.0]
  def change
    create_table :dealers do |t|
      t.string :currency
      t.string :name
      t.string :account_number
      t.integer :min_amount
      t.integer :max_amount
      # how many times would a person deal with
      # this dealer during 100 days
      t.integer :frequency
      t.boolean :is_vendor

      t.timestamps
    end
  end
end
