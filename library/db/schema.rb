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

ActiveRecord::Schema.define(version: 2020_08_17_125135) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "description", limit: 300, null: false
    t.datetime "created_time", default: "2020-06-25 08:01:18"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "user_id", null: false
    t.float "ordered_price", null: false
    t.integer "ordered_quantity", null: false
    t.datetime "orderd_date", null: false
    t.integer "order_status", default: 0
    t.integer "payment_id", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payment_transactions", force: :cascade do |t|
    t.integer "payment_id"
    t.string "action"
    t.integer "amount"
    t.boolean "success"
    t.string "authorization"
    t.string "message"
    t.text "params"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string "email"
    t.string "token"
    t.integer "user_id"
    t.float "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", limit: 150, null: false
    t.integer "variant_id"
    t.integer "category_id"
    t.string "description", limit: 300
    t.string "image_url"
    t.float "price"
    t.integer "quantity"
    t.integer "seller_id"
    t.datetime "created_date", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "password_digest"
    t.string "address", limit: 500
    t.integer "user_status", default: 1
    t.integer "user_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "description", limit: 300, null: false
    t.string "comment", limit: 500
    t.datetime "created_time", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
