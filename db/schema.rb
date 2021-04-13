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

ActiveRecord::Schema.define(version: 2021_04_13_060350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_service_line_channels", force: :cascade do |t|
    t.bigint "business_service_line_id"
    t.bigint "channel_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_service_line_id"], name: "bsl_channels_on_bsl_id"
    t.index ["channel_id"], name: "bsl_channels_on_channel_id"
  end

  create_table "business_service_line_products", force: :cascade do |t|
    t.bigint "business_service_line_id"
    t.bigint "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_service_line_id"], name: "bsl_products_on_bsl_id"
    t.index ["product_id"], name: "bsl_products_on_product_id"
  end

  create_table "business_service_lines", force: :cascade do |t|
    t.bigint "unit_id"
    t.string "name"
    t.text "description"
    t.integer "tier"
    t.integer "region"
    t.integer "country"
    t.string "institution"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_business_service_lines_on_unit_id"
  end

  create_table "channels", force: :cascade do |t|
    t.bigint "unit_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_channels_on_unit_id"
  end

  create_table "cloud_hosting_providers", force: :cascade do |t|
    t.bigint "supplier_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_id"], name: "index_cloud_hosting_providers_on_supplier_id"
  end

  create_table "incidents", force: :cascade do |t|
    t.bigint "supplier_id"
    t.float "severity"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_id"], name: "index_incidents_on_supplier_id"
  end

  create_table "key_contact_suppliers", force: :cascade do |t|
    t.bigint "key_contact_id"
    t.bigint "supplier_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key_contact_id"], name: "index_key_contact_suppliers_on_key_contact_id"
    t.index ["supplier_id"], name: "index_key_contact_suppliers_on_supplier_id"
  end

  create_table "key_contacts", force: :cascade do |t|
    t.bigint "unit_id"
    t.string "name"
    t.string "email"
    t.string "job_title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_key_contacts_on_unit_id"
  end

  create_table "material_risk_takers", force: :cascade do |t|
    t.bigint "business_service_line_id"
    t.string "name"
    t.string "title"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_service_line_id"], name: "index_material_risk_takers_on_business_service_line_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "unit_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_products_on_unit_id"
  end

  create_table "relationship_owners", force: :cascade do |t|
    t.bigint "supplier_id"
    t.string "name"
    t.string "email"
    t.string "job_title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_id"], name: "index_relationship_owners_on_supplier_id"
  end

  create_table "risk_appetites", force: :cascade do |t|
    t.bigint "business_service_line_id"
    t.integer "creator_id"
    t.string "type"
    t.text "description"
    t.integer "risk_appetite_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_service_line_id"], name: "index_risk_appetites_on_business_service_line_id"
    t.index ["creator_id"], name: "index_risk_appetites_on_creator_id"
  end

  create_table "slas", force: :cascade do |t|
    t.string "slaable_type"
    t.bigint "slaable_id"
    t.float "service_level_agreement"
    t.float "service_level_objective"
    t.integer "recovery_point_objective"
    t.integer "severity1_response_time"
    t.integer "severity2_response_time"
    t.integer "severity3_response_time"
    t.integer "severity4_response_time"
    t.integer "severity1_restoration_service_time"
    t.integer "severity2_restoration_service_time"
    t.integer "severity3_restoration_service_time"
    t.integer "severity4_restoration_service_time"
    t.integer "support_hours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slaable_type", "slaable_id"], name: "index_slas_on_slaable_type_and_slaable_id"
  end

  create_table "steps", force: :cascade do |t|
    t.bigint "business_service_line_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_service_line_id"], name: "index_steps_on_business_service_line_id"
  end

  create_table "supplier_contact_suppliers", force: :cascade do |t|
    t.bigint "supplier_contact_id"
    t.bigint "supplier_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_contact_id"], name: "index_supplier_contact_suppliers_on_supplier_contact_id"
    t.index ["supplier_id"], name: "index_supplier_contact_suppliers_on_supplier_id"
  end

  create_table "supplier_contacts", force: :cascade do |t|
    t.bigint "unit_id"
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_supplier_contacts_on_unit_id"
  end

  create_table "supplier_steps", force: :cascade do |t|
    t.bigint "step_id"
    t.bigint "supplier_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["step_id"], name: "index_supplier_steps_on_step_id"
    t.index ["supplier_id"], name: "index_supplier_steps_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.bigint "unit_id"
    t.string "name"
    t.integer "contracting_terms"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_suppliers_on_unit_id"
  end

  create_table "technologies", force: :cascade do |t|
    t.bigint "supplier_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_id"], name: "index_technologies_on_supplier_id"
  end

  create_table "units", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "parent_id"
    t.string "type"
    t.string "name"
    t.integer "region"
    t.integer "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id"], name: "index_units_on_parent_id"
    t.index ["user_id"], name: "index_units_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vulnerabilities", force: :cascade do |t|
    t.bigint "business_service_line_id"
    t.string "type"
    t.integer "time_in_seconds"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_service_line_id"], name: "index_vulnerabilities_on_business_service_line_id"
  end

  add_foreign_key "business_service_line_channels", "business_service_lines"
  add_foreign_key "business_service_line_channels", "channels"
  add_foreign_key "business_service_line_products", "business_service_lines"
  add_foreign_key "business_service_line_products", "products"
  add_foreign_key "business_service_lines", "units"
  add_foreign_key "channels", "units"
  add_foreign_key "cloud_hosting_providers", "suppliers"
  add_foreign_key "incidents", "suppliers"
  add_foreign_key "key_contact_suppliers", "key_contacts"
  add_foreign_key "key_contact_suppliers", "suppliers"
  add_foreign_key "key_contacts", "units"
  add_foreign_key "material_risk_takers", "business_service_lines"
  add_foreign_key "products", "units"
  add_foreign_key "relationship_owners", "suppliers"
  add_foreign_key "risk_appetites", "business_service_lines"
  add_foreign_key "steps", "business_service_lines"
  add_foreign_key "supplier_contact_suppliers", "supplier_contacts"
  add_foreign_key "supplier_contact_suppliers", "suppliers"
  add_foreign_key "supplier_contacts", "units"
  add_foreign_key "supplier_steps", "steps"
  add_foreign_key "supplier_steps", "suppliers"
  add_foreign_key "suppliers", "units"
  add_foreign_key "technologies", "suppliers"
  add_foreign_key "units", "users"
  add_foreign_key "vulnerabilities", "business_service_lines"
end
