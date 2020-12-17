# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_12_103241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "balance", precision: 20, scale: 2
    t.string "account_number"
    t.string "cvv"
    t.date "expiry_date"
    t.string "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "styles", force: :cascade do |t|
    t.string "bank_name"
    t.string "font_family"
    t.text "navbar_md"
    t.string "home_main_marketing_title"
    t.string "home_main_marketing_subtitle"
    t.string "home_main_marketing_message_1"
    t.text "home_main_marketing_text_1"
    t.string "home_main_marketing_message_2"
    t.text "home_main_marketing_text_2"
    t.string "home_main_marketing_message_3"
    t.text "home_main_marketing_text_3"
    t.text "home_footer_md"
    t.string "home_footer_text_color"
    t.string "home_background_color"
    t.text "home_links_1"
    t.text "home_links_2"
    t.string "dashboard_action_head_color"
    t.string "dashboard_action_head_font_color"
    t.string "dashboard_summary_head_color"
    t.string "dashboard_summary_head_font_color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount", precision: 20, scale: 2, null: false
    t.string "currency", null: false
    t.string "dealer_account_number", null: false
    t.string "dealer_name", null: false
    t.string "reference"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id"
    t.index ["account_id"], name: "index_transactions_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname", default: "", null: false
    t.string "lastname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "phone", default: "", null: false
    t.datetime "birth_date", null: false
    t.boolean "is_female"
    t.string "postcode"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "country"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.string "admin_passphrase_digest", default: ""
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "transactions", "accounts"
end
