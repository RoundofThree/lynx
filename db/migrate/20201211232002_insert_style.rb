class InsertStyle < ActiveRecord::Migration[6.0]
  def change
    # create a style
    Style.create! do |s|
      s.bank_name = "Test Bank"
    end
  end
end
