class CreateStyles < ActiveRecord::Migration[6.0]
  def change
    create_table :styles do |t|
      t.string :bank_name
      t.string :dashboard_color
      # t.  :header_logo
      # t.  :simple_logo
      t.timestamps
    end
  end
end
