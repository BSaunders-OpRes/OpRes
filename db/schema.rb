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

ActiveRecord::Schema.define(version: 2021_07_01_054133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cost_centre_id"
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

  create_table "cloud_hosting_provider_recipients", force: :cascade do |t|
    t.bigint "cloud_hosting_provider_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "chp_recipientable_type"
    t.bigint "chp_recipientable_id"
    t.index ["chp_recipientable_type", "chp_recipientable_id"], name: "chp_on_recipient_id"
    t.index ["cloud_hosting_provider_id"], name: "chp_suppliers_on_chp_id"
  end

  create_table "cloud_hosting_provider_region_recipients", force: :cascade do |t|
    t.bigint "cloud_hosting_provider_region_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "chpr_recipientable_type"
    t.bigint "chpr_recipientable_id"
    t.index ["chpr_recipientable_type", "chpr_recipientable_id"], name: "chpr_on_recipient_id"
    t.index ["cloud_hosting_provider_region_id"], name: "supplier_chpr_on_chp_id"
  end

  create_table "cloud_hosting_provider_regions", force: :cascade do |t|
    t.bigint "cloud_hosting_provider_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cloud_hosting_provider_id"], name: "chpr_on_chp_id"
  end

  create_table "cloud_hosting_provider_service_recipients", force: :cascade do |t|
    t.bigint "cloud_hosting_provider_service_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "chps_recipientable_type"
    t.bigint "chps_recipientable_id"
    t.index ["chps_recipientable_type", "chps_recipientable_id"], name: "chps_on_recipient_id"
    t.index ["cloud_hosting_provider_service_id"], name: "supplier_chps_on_chps_id"
  end

  create_table "cloud_hosting_provider_services", force: :cascade do |t|
    t.bigint "cloud_hosting_provider_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cloud_hosting_provider_id"], name: "chps_on_chp_id"
  end

  create_table "cloud_hosting_providers", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries", force: :cascade do |t|
    t.bigint "region_id"
    t.string "continent"
    t.string "alpha2"
    t.string "alpha3"
    t.string "country_code"
    t.string "international_prefix"
    t.string "ioc"
    t.string "gec"
    t.string "name"
    t.json "national_destination_code_lengths"
    t.json "national_number_lengths"
    t.string "national_prefix"
    t.string "number"
    t.string "region_name"
    t.string "subregion"
    t.string "world_region"
    t.string "un_locode"
    t.string "nationality"
    t.boolean "postal_code"
    t.string "postal_code_format"
    t.json "unofficial_names"
    t.json "languages_official"
    t.json "languages_spoken"
    t.json "geo"
    t.string "currency_code"
    t.string "start_of_week"
    t.json "translations"
    t.json "translated_names"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["region_id"], name: "index_countries_on_region_id"
  end

  create_table "country_currencies", force: :cascade do |t|
    t.bigint "country_id"
    t.bigint "currency_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_country_currencies_on_country_id"
    t.index ["currency_id"], name: "index_country_currencies_on_currency_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "iso_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "currency_recipients", force: :cascade do |t|
    t.bigint "currency_id"
    t.string "currency_recipientable_type"
    t.bigint "currency_recipientable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency_id"], name: "index_currency_recipients_on_currency_id"
    t.index ["currency_recipientable_type", "currency_recipientable_id"], name: "currency_recipient_on_recipientable_type_id"
  end

  create_table "incidents", force: :cascade do |t|
    t.bigint "supplier_id"
    t.float "severity"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_id"], name: "index_incidents_on_supplier_id"
  end

  create_table "institution_products", force: :cascade do |t|
    t.bigint "institution_id"
    t.bigint "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_institution_products_on_institution_id"
    t.index ["product_id"], name: "index_institution_products_on_product_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.bigint "unit_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_institutions_on_unit_id"
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

  create_table "managers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "unit_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_managers_on_unit_id"
    t.index ["user_id"], name: "index_managers_on_user_id"
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

  create_table "pre_channels", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pre_institution_products", force: :cascade do |t|
    t.bigint "pre_institution_id"
    t.bigint "pre_product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pre_institution_id"], name: "index_pre_institution_products_on_pre_institution_id"
    t.index ["pre_product_id"], name: "index_pre_institution_products_on_pre_product_id"
  end

  create_table "pre_institutions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "unit_type"
  end

  create_table "pre_product_channels", force: :cascade do |t|
    t.bigint "pre_product_id"
    t.bigint "pre_channel_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pre_channel_id"], name: "index_pre_product_channels_on_pre_channel_id"
    t.index ["pre_product_id"], name: "index_pre_product_channels_on_pre_product_id"
  end

  create_table "pre_products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_channels", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "channel_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_product_channels_on_channel_id"
    t.index ["product_id"], name: "index_product_channels_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "unit_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_products_on_unit_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "risk_appetite_justifications", force: :cascade do |t|
    t.bigint "risk_appetite_id"
    t.bigint "user_id"
    t.text "justification"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["risk_appetite_id"], name: "index_risk_appetite_justifications_on_risk_appetite_id"
    t.index ["user_id"], name: "index_risk_appetite_justifications_on_user_id"
  end

  create_table "risk_appetites", force: :cascade do |t|
    t.bigint "business_service_line_id"
    t.string "name"
    t.float "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "kind", default: 0
    t.integer "label", default: 0
    t.index ["business_service_line_id"], name: "index_risk_appetites_on_business_service_line_id"
  end

  create_table "slas", force: :cascade do |t|
    t.string "slaable_type"
    t.bigint "slaable_id"
    t.float "service_level_agreement"
    t.float "service_level_objective"
    t.integer "recovery_point_objective"
    t.integer "severity1"
    t.integer "severity2"
    t.integer "severity3"
    t.integer "severity4"
    t.integer "severity1_restoration"
    t.integer "severity2_restoration"
    t.integer "severity3_restoration"
    t.integer "severity4_restoration"
    t.integer "support_hours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "recovery_time_objective"
    t.string "support_hours_other"
    t.index ["slaable_type", "slaable_id"], name: "index_slas_on_slaable_type_and_slaable_id"
  end

  create_table "social_accounts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "steps", force: :cascade do |t|
    t.bigint "business_service_line_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number"
    t.index ["business_service_line_id"], name: "index_steps_on_business_service_line_id"
  end

  create_table "sub_suppliers", force: :cascade do |t|
    t.bigint "supplier_id"
    t.string "type"
    t.string "name"
    t.string "cloud_hosting_provider_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_id"], name: "index_sub_suppliers_on_supplier_id"
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

  create_table "supplier_social_accounts", force: :cascade do |t|
    t.bigint "supplier_id"
    t.bigint "social_account_id"
    t.text "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["social_account_id"], name: "index_supplier_social_accounts_on_social_account_id"
    t.index ["supplier_id"], name: "index_supplier_social_accounts_on_supplier_id"
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
    t.integer "party_type"
    t.integer "importance_level"
    t.string "contracting_terms_other"
    t.date "start_date"
    t.date "end_date"
    t.string "cloud_hosting_provider_description"
    t.integer "consumption_model", default: 0
    t.string "consumption_model_other"
    t.index ["unit_id"], name: "index_suppliers_on_unit_id"
  end

  create_table "technologies", force: :cascade do |t|
    t.bigint "supplier_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_id"], name: "index_technologies_on_supplier_id"
  end

  create_table "unit_product_channels", force: :cascade do |t|
    t.bigint "unit_product_id"
    t.bigint "channel_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_unit_product_channels_on_channel_id"
    t.index ["unit_product_id"], name: "index_unit_product_channels_on_unit_product_id"
  end

  create_table "unit_products", force: :cascade do |t|
    t.bigint "unit_id"
    t.bigint "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_unit_products_on_product_id"
    t.index ["unit_id"], name: "index_unit_products_on_unit_id"
  end

  create_table "units", force: :cascade do |t|
    t.integer "parent_id"
    t.string "type"
    t.integer "unit_type"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "institution_id"
    t.bigint "region_id"
    t.bigint "country_id"
    t.integer "status", default: 0
    t.index ["country_id"], name: "index_units_on_country_id"
    t.index ["institution_id"], name: "index_units_on_institution_id"
    t.index ["parent_id"], name: "index_units_on_parent_id"
    t.index ["region_id"], name: "index_units_on_region_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "unit_id"
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "job_title"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unit_id"], name: "index_users_on_unit_id"
  end

  create_table "vulnerabilities", force: :cascade do |t|
    t.bigint "business_service_line_id"
    t.string "type"
    t.integer "time_in_seconds"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_service_line_id"], name: "index_vulnerabilities_on_business_service_line_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "business_service_line_channels", "business_service_lines"
  add_foreign_key "business_service_line_channels", "channels"
  add_foreign_key "business_service_line_products", "business_service_lines"
  add_foreign_key "business_service_line_products", "products"
  add_foreign_key "business_service_lines", "units"
  add_foreign_key "channels", "units"
  add_foreign_key "cloud_hosting_provider_recipients", "cloud_hosting_providers"
  add_foreign_key "cloud_hosting_provider_region_recipients", "cloud_hosting_provider_regions"
  add_foreign_key "cloud_hosting_provider_regions", "cloud_hosting_providers"
  add_foreign_key "cloud_hosting_provider_service_recipients", "cloud_hosting_provider_services"
  add_foreign_key "cloud_hosting_provider_services", "cloud_hosting_providers"
  add_foreign_key "countries", "regions"
  add_foreign_key "country_currencies", "countries"
  add_foreign_key "country_currencies", "currencies"
  add_foreign_key "incidents", "suppliers"
  add_foreign_key "institution_products", "institutions"
  add_foreign_key "institution_products", "products"
  add_foreign_key "institutions", "units"
  add_foreign_key "key_contact_suppliers", "key_contacts"
  add_foreign_key "key_contact_suppliers", "suppliers"
  add_foreign_key "key_contacts", "units"
  add_foreign_key "managers", "units"
  add_foreign_key "managers", "users"
  add_foreign_key "material_risk_takers", "business_service_lines"
  add_foreign_key "pre_institution_products", "pre_institutions"
  add_foreign_key "pre_institution_products", "pre_products"
  add_foreign_key "pre_product_channels", "pre_channels"
  add_foreign_key "pre_product_channels", "pre_products"
  add_foreign_key "product_channels", "channels"
  add_foreign_key "product_channels", "products"
  add_foreign_key "products", "units"
  add_foreign_key "relationship_owners", "suppliers"
  add_foreign_key "risk_appetite_justifications", "risk_appetites"
  add_foreign_key "risk_appetite_justifications", "users"
  add_foreign_key "risk_appetites", "business_service_lines"
  add_foreign_key "steps", "business_service_lines"
  add_foreign_key "sub_suppliers", "suppliers"
  add_foreign_key "supplier_contact_suppliers", "supplier_contacts"
  add_foreign_key "supplier_contact_suppliers", "suppliers"
  add_foreign_key "supplier_contacts", "units"
  add_foreign_key "supplier_social_accounts", "social_accounts"
  add_foreign_key "supplier_social_accounts", "suppliers"
  add_foreign_key "supplier_steps", "steps"
  add_foreign_key "supplier_steps", "suppliers"
  add_foreign_key "suppliers", "units"
  add_foreign_key "technologies", "suppliers"
  add_foreign_key "unit_product_channels", "channels"
  add_foreign_key "unit_product_channels", "unit_products"
  add_foreign_key "unit_products", "products"
  add_foreign_key "unit_products", "units"
  add_foreign_key "units", "countries"
  add_foreign_key "units", "institutions"
  add_foreign_key "units", "regions"
  add_foreign_key "users", "units"
  add_foreign_key "vulnerabilities", "business_service_lines"
end
