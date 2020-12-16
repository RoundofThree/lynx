class CreateStyles < ActiveRecord::Migration[6.0]
  def change
    create_table :styles do |t|
      t.string :bank_name
      t.string :home_main_marketing_title
      t.string :home_main_marketing_subtitle
      t.string :home_main_marketing_message_1
      t.text :home_main_marketing_text_1
      t.string :home_main_marketing_message_2
      t.text :home_main_marketing_text_2
      t.string :home_main_marketing_message_3
      t.text :home_main_marketing_text_3
      t.string :dashboard_color
      t.timestamps
    end
  end
end
