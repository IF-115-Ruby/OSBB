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

ActiveRecord::Schema.define(version: 2020_10_09_201842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billing_contracts", force: :cascade do |t|
    t.string "contract_num", limit: 50, null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contract_num"], name: "index_billing_contracts_on_contract_num"
  end

  create_table "bills", force: :cascade do |t|
    t.bigint "billing_contract_id"
    t.datetime "date"
    t.decimal "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "billing_contracts_id", null: false
    t.index ["billing_contract_id"], name: "index_bills_on_billing_contract_id"
    t.index ["billing_contracts_id"], name: "index_bills_on_billing_contracts_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "company_type"
    t.string "phone", limit: 14
    t.string "email"
    t.string "website"
    t.integer "fax"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_companies_on_name"
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
    t.bigint "billing_contracts_id", null: false
    t.index ["billing_contract_id"], name: "index_payments_on_billing_contract_id"
    t.index ["billing_contracts_id"], name: "index_payments_on_billing_contracts_id"
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
    t.string "sex"
    t.integer "role"
    t.bigint "osbb_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["osbb_id"], name: "index_users_on_osbb_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bills", "billing_contracts", column: "billing_contracts_id"
  add_foreign_key "payments", "billing_contracts", column: "billing_contracts_id"
  add_foreign_key "users", "osbbs"
end
