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

ActiveRecord::Schema[7.2].define(version: 2024_10_26_214706) do
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
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "beverages", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "calories"
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_beverages_on_restaurant_id"
  end

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "calories"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "restaurant_id", null: false
    t.index ["restaurant_id"], name: "index_dishes_on_restaurant_id"
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
    t.integer "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "brand_name"
    t.string "code"
    t.index ["admin_id"], name: "index_restaurants_on_admin_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "beverages", "restaurants"
  add_foreign_key "dishes", "restaurants"
  add_foreign_key "restaurant_schedules", "restaurants"
  add_foreign_key "restaurants", "admins"
end
