class CreateStyles < ActiveRecord::Migration[6.0]
  def change
    create_table :styles do |t|
      t.string :bank_name
      t.string :font_family
      t.text :navbar_md
      t.string :home_main_marketing_title
      t.string :home_main_marketing_subtitle
      t.string :home_main_marketing_message_1
      t.text :home_main_marketing_text_1
      t.string :home_main_marketing_message_2
      t.text :home_main_marketing_text_2
      t.string :home_main_marketing_message_3
      t.text :home_main_marketing_text_3
      t.text :home_footer_md
      t.string :home_footer_text_color
      t.string :home_background_color
      t.text :home_links_1
      t.text :home_links_2
      t.string :dashboard_action_head_color
      t.string :dashboard_action_head_font_color
      t.string :dashboard_summary_head_color
      t.string :dashboard_summary_head_font_color
      t.string :sign_up_head_size
      t.timestamps
    end
  end
end
