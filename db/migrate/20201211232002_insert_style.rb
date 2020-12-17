class InsertStyle < ActiveRecord::Migration[6.0]
  def change
    # create a style
    Style.create! do |s|
      s.bank_name = "Test Bank"
      s.dashboard_color = "#e7cf8a"  # old yellow
    end
  end
end
