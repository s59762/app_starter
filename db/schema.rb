# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_07_21_121247) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.string "name"
    t.integer "role", default: 0
    t.boolean "is_suspended", default: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "banners", force: :cascade do |t|
    t.string "image"
    t.string "alt_text"
    t.integer "use_type", default: 0
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brand_banners", force: :cascade do |t|
    t.string "image"
    t.string "alt_text"
    t.bigint "brand_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brand_banners_on_brand_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.string "introduce"
    t.text "description"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "products_count", default: 0
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "editor_attachments", force: :cascade do |t|
    t.string "file"
    t.string "original_filename"
    t.string "attachable_type"
    t.bigint "attachable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachable_type", "attachable_id"], name: "index_editor_attachments_on_attachable_type_and_attachable_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "products_count", default: 0
    t.index ["parent_id"], name: "index_product_categories_on_parent_id"
  end

  create_table "product_images", force: :cascade do |t|
    t.string "image"
    t.string "original_filename"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_cover", default: false
    t.bigint "variant_id"
    t.index ["product_id"], name: "index_product_images_on_product_id"
    t.index ["variant_id"], name: "index_product_images_on_variant_id"
  end

  create_table "product_option_types", force: :cascade do |t|
    t.string "name"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_option_types_on_product_id"
  end

  create_table "product_option_values", force: :cascade do |t|
    t.string "value"
    t.bigint "option_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_type_id"], name: "index_product_option_values_on_option_type_id"
  end

  create_table "product_variants", force: :cascade do |t|
    t.string "name"
    t.string "sku"
    t.integer "original_price_cents", default: 0, null: false
    t.string "original_price_currency", default: "TWD", null: false
    t.integer "sell_price_cents", default: 0, null: false
    t.string "sell_price_currency", default: "TWD", null: false
    t.integer "discounted_price_cents", default: 0, null: false
    t.string "discounted_price_currency", default: "TWD", null: false
    t.decimal "weight"
    t.decimal "width"
    t.decimal "depth"
    t.decimal "height"
    t.boolean "is_master", default: false
    t.text "description"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "option_value_ids", default: []
    t.integer "stock", default: 0
    t.index ["product_id"], name: "index_product_variants_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "category_id"
    t.integer "cover"
    t.boolean "is_preorder", default: false
    t.jsonb "properties", default: []
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "brand_id"
    t.string "meta_title"
    t.string "meta_description"
    t.string "meta_keywords"
    t.integer "total_stock", default: 0
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.integer "thing_id"
    t.string "thing_type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true
  end

  create_table "user_collections", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_user_collections_on_product_id"
    t.index ["user_id"], name: "index_user_collections_on_user_id"
  end

  create_table "user_shipping_infos", force: :cascade do |t|
    t.string "recipient"
    t.string "phone"
    t.jsonb "address"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_shipping_infos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "brand_banners", "brands"
  add_foreign_key "product_categories", "product_categories", column: "parent_id"
  add_foreign_key "product_images", "product_variants", column: "variant_id"
  add_foreign_key "product_images", "products"
  add_foreign_key "product_option_types", "products"
  add_foreign_key "product_option_values", "product_option_types", column: "option_type_id"
  add_foreign_key "product_variants", "products"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "product_categories", column: "category_id"
  add_foreign_key "user_collections", "products"
  add_foreign_key "user_collections", "users"
  add_foreign_key "user_shipping_infos", "users"
end
