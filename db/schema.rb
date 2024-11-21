# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_21_122558) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "last_name"
    t.integer "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "restaurant_owner"
    t.integer "admin_type", default: 2
    t.integer "restaurant_id"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["restaurant_id"], name: "index_admins_on_restaurant_id"
  end

  create_table "beverage_portions", force: :cascade do |t|
    t.string "description"
    t.integer "beverage_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price"
    t.index ["beverage_id"], name: "index_beverage_portions_on_beverage_id"
  end

  create_table "beverage_previous_prices", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "beverage_portion_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price"
    t.index ["beverage_portion_id"], name: "index_beverage_previous_prices_on_beverage_portion_id"
  end

  create_table "beverages", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "calories"
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 2
    t.index ["restaurant_id"], name: "index_beverages_on_restaurant_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dish_portions", force: :cascade do |t|
    t.string "description"
    t.integer "dish_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price"
    t.index ["dish_id"], name: "index_dish_portions_on_dish_id"
  end

  create_table "dish_previous_prices", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "dish_portion_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price"
    t.index ["dish_portion_id"], name: "index_dish_previous_prices_on_dish_portion_id"
  end

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "calories"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "restaurant_id", null: false
    t.integer "status", default: 2
    t.index ["restaurant_id"], name: "index_dishes_on_restaurant_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "menu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "beverage"
    t.string "dish"
    t.integer "dish_id"
    t.integer "beverage_id"
    t.integer "cart_id"
    t.index ["beverage_id"], name: "index_items_on_beverage_id"
    t.index ["cart_id"], name: "index_items_on_cart_id"
    t.index ["dish_id"], name: "index_items_on_dish_id"
    t.index ["menu_id"], name: "index_items_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.index ["restaurant_id"], name: "index_menus_on_restaurant_id"
  end

  create_table "orderable_beverages", force: :cascade do |t|
    t.integer "quantity"
    t.integer "cart_id"
    t.integer "order_id"
    t.integer "beverage_portion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beverage_portion_id"], name: "index_orderable_beverages_on_beverage_portion_id"
    t.index ["cart_id"], name: "index_orderable_beverages_on_cart_id"
    t.index ["order_id"], name: "index_orderable_beverages_on_order_id"
  end

  create_table "orderable_dishes", force: :cascade do |t|
    t.integer "quantity"
    t.integer "cart_id"
    t.integer "order_id"
    t.integer "dish_portion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_orderable_dishes_on_cart_id"
    t.index ["dish_portion_id"], name: "index_orderable_dishes_on_dish_portion_id"
    t.index ["order_id"], name: "index_orderable_dishes_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.string "telephone_number"
    t.string "email"
    t.string "cpf"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "restaurant_id", null: false
    t.string "code"
    t.string "description"
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id"
  end

  create_table "restaurant_schedules", force: :cascade do |t|
    t.time "mon_open"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "mon_close"
    t.time "tue_open"
    t.time "tue_close"
    t.time "wed_open"
    t.time "wed_close"
    t.time "thu_open"
    t.time "thu_close"
    t.time "fri_open"
    t.time "fri_close"
    t.time "sat_open"
    t.time "sat_close"
    t.time "sun_open"
    t.time "sun_close"
    t.integer "restaurant_id", null: false
    t.index ["restaurant_id"], name: "index_restaurant_schedules_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "corporate_name"
    t.integer "cnpj"
    t.string "full_address"
    t.string "telephone_number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "brand_name"
    t.string "code"
    t.integer "admin_id", null: false
    t.index ["admin_id"], name: "index_restaurants_on_admin_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "dish_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_taggings_on_dish_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "restaurant_id", null: false
    t.index ["restaurant_id"], name: "index_tags_on_restaurant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "cpf"
    t.integer "status", default: 0
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["restaurant_id"], name: "index_users_on_restaurant_id"
  end

  create_table "workers", force: :cascade do |t|
    t.string "email"
    t.string "cpf"
    t.integer "status", default: 0
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_workers_on_restaurant_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admins", "restaurants"
  add_foreign_key "beverage_portions", "beverages"
  add_foreign_key "beverage_previous_prices", "beverage_portions"
  add_foreign_key "beverages", "restaurants"
  add_foreign_key "dish_portions", "dishes"
  add_foreign_key "dish_previous_prices", "dish_portions"
  add_foreign_key "dishes", "restaurants"
  add_foreign_key "items", "beverages"
  add_foreign_key "items", "carts"
  add_foreign_key "items", "dishes"
  add_foreign_key "items", "menus"
  add_foreign_key "menus", "restaurants"
  add_foreign_key "orderable_beverages", "beverage_portions"
  add_foreign_key "orderable_beverages", "carts"
  add_foreign_key "orderable_beverages", "orders"
  add_foreign_key "orderable_dishes", "carts"
  add_foreign_key "orderable_dishes", "dish_portions"
  add_foreign_key "orderable_dishes", "orders"
  add_foreign_key "orders", "restaurants"
  add_foreign_key "restaurant_schedules", "restaurants"
  add_foreign_key "restaurants", "admins"
  add_foreign_key "taggings", "dishes"
  add_foreign_key "taggings", "tags"
  add_foreign_key "tags", "restaurants"
  add_foreign_key "users", "restaurants"
  add_foreign_key "workers", "restaurants"
end
