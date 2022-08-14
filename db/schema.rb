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

ActiveRecord::Schema.define(version: 2022_08_14_142024) do

  create_table "deputies", force: :cascade do |t|
    t.integer "number_deputy"
    t.string "name"
    t.string "state"
    t.string "party"
    t.integer "legislature"
    t.string "civil_name"
    t.string "photo_url"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.integer "type_of_expense"
    t.string "description"
    t.datetime "date"
    t.string "provider_document"
    t.string "provider_name"
    t.decimal "value"
    t.string "document_url"
    t.integer "deputy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deputy_id"], name: "index_expenses_on_deputy_id"
  end

  add_foreign_key "expenses", "deputies"
end
