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

ActiveRecord::Schema.define(version: 2020_11_29_150927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "edrpou"
    t.string "iban"
    t.text "purpose"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_accounts_on_company_id"
    t.index ["edrpou"], name: "index_accounts_on_edrpou", unique: true
    t.index ["iban"], name: "index_accounts_on_iban", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "street"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "billing_contracts", force: :cascade do |t|
    t.string "contract_num", limit: 50, null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id"
    t.bigint "user_id"
    t.index ["company_id"], name: "index_billing_contracts_on_company_id"
    t.index ["contract_num", "company_id"], name: "index_billing_contracts_on_contract_num_and_company_id", unique: true
    t.index ["contract_num"], name: "index_billing_contracts_on_contract_num"
    t.index ["user_id", "company_id"], name: "index_billing_contracts_on_user_id_and_company_id", unique: true
    t.index ["user_id"], name: "index_billing_contracts_on_user_id"
  end

  create_table "bills", force: :cascade do |t|
    t.bigint "billing_contract_id"
    t.datetime "date"
    t.decimal "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "meter_reading"
    t.index ["billing_contract_id"], name: "index_bills_on_billing_contract_id"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.integer "company_type"
    t.string "phone", limit: 14
    t.string "email"
    t.string "website"
    t.integer "fax"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "payment_coefficient"
    t.index ["name"], name: "index_companies_on_name"
  end

  create_table "meter_readings", force: :cascade do |t|
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "billing_contract_id"
    t.index ["billing_contract_id"], name: "index_meter_readings_on_billing_contract_id"
  end

  create_table "news", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "osbb_id"
    t.string "title"
    t.string "short_description"
    t.text "long_description"
    t.boolean "is_visible"
    t.boolean "is_private"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.index ["osbb_id"], name: "index_news_on_osbb_id"
    t.index ["user_id"], name: "index_news_on_user_id"
  end

  create_table "osbbs", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "website"
    t.boolean "is_available"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_osbbs_on_name"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "billing_contract_id"
    t.datetime "date"
    t.decimal "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["billing_contract_id"], name: "index_payments_on_billing_contract_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 50, null: false
    t.string "last_name", limit: 50, null: false
    t.string "email", limit: 254, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "mobile"
    t.date "birthday"
    t.string "avatar"
    t.integer "sex"
    t.integer "role"
    t.bigint "osbb_id"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["osbb_id"], name: "index_users_on_osbb_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "companies"
  add_foreign_key "billing_contracts", "companies"
  add_foreign_key "billing_contracts", "users"
  add_foreign_key "bills", "billing_contracts"
  add_foreign_key "meter_readings", "billing_contracts"
  add_foreign_key "payments", "billing_contracts"
  add_foreign_key "users", "osbbs"
end
