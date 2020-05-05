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

ActiveRecord::Schema.define(version: 2020_05_05_151947) do

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

  create_table "characters", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.integer "age"
    t.integer "gender"
    t.boolean "real_world"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "organizations_count", default: 0
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
  end

  create_table "industries", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jwt_blacklists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_jwt_blacklists_on_jti"
  end

  create_table "organization_characters", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "organization_id", null: false
    t.bigint "world_role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["character_id", "organization_id", "world_role_id"], name: "character_id_organization_id_world_role_id", unique: true
    t.index ["character_id"], name: "index_organization_characters_on_character_id"
    t.index ["organization_id"], name: "index_organization_characters_on_organization_id"
    t.index ["world_role_id"], name: "index_organization_characters_on_world_role_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "real_world"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "characters_count", default: 0
    t.bigint "industry_id", null: false
    t.index ["industry_id"], name: "index_organizations_on_industry_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "world_org_characters", force: :cascade do |t|
    t.bigint "world_organization_id", null: false
    t.bigint "character_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "world_role_id", null: false
    t.index ["character_id", "world_organization_id", "world_role_id"], name: "character_id_world_organization_id_world_role_id", unique: true
    t.index ["character_id"], name: "index_world_org_characters_on_character_id"
    t.index ["world_organization_id"], name: "index_world_org_characters_on_world_organization_id"
    t.index ["world_role_id"], name: "index_world_org_characters_on_world_role_id"
  end

  create_table "world_organizations", force: :cascade do |t|
    t.bigint "world_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_world_organizations_on_organization_id"
    t.index ["world_id"], name: "index_world_organizations_on_world_id"
  end

  create_table "world_roles", force: :cascade do |t|
    t.string "name", null: false
  create_table "concepts", force: :cascade do |t|
    t.string "label"
    t.text "synonyms", default: [], array: true
    t.integer "relevance"
    t.boolean "mandatory"
    t.string "conceptable_type"
    t.bigint "conceptable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conceptable_type", "conceptable_id"], name: "index_concepts_on_conceptable_type_and_conceptable_id"
  end

  create_table "entities", force: :cascade do |t|
    t.string "label"
    t.text "synonyms", default: [], array: true
    t.integer "relevance"
    t.boolean "mandatory"
    t.string "entitable_type"
    t.bigint "entitable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["entitable_type", "entitable_id"], name: "index_entities_on_entitable_type_and_entitable_id"
  end

  create_table "examples", force: :cascade do |t|
    t.text "body"
    t.string "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "worlds", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "world_code", null: false
    t.boolean "is_private"
    t.integer "learn_mods_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "customer_id", null: false
    t.index ["customer_id"], name: "index_worlds_on_customer_id"
    t.index ["world_code"], name: "index_worlds_on_world_code", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "organization_characters", "characters"
  add_foreign_key "organization_characters", "organizations"
  add_foreign_key "organization_characters", "world_roles"
  add_foreign_key "organizations", "industries"
  add_foreign_key "world_org_characters", "characters"
  add_foreign_key "world_org_characters", "world_organizations"
  add_foreign_key "world_org_characters", "world_roles"
  add_foreign_key "world_organizations", "organizations"
  add_foreign_key "world_organizations", "worlds"
  add_foreign_key "worlds", "customers"
  
  create_table "keywords", force: :cascade do |t|
    t.string "label"
    t.text "synonyms", default: [], array: true
    t.integer "relevance"
    t.boolean "mandatory"
    t.string "keywordable_type"
    t.bigint "keywordable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["keywordable_type", "keywordable_id"], name: "index_keywords_on_keywordable_type_and_keywordable_id"
  end

end
