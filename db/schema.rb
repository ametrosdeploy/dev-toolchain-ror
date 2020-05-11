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

ActiveRecord::Schema.define(version: 2020_05_08_191808) do

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

  create_table "chat_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
  end

  create_table "cutomer_learn_mods", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "learn_mod_id", null: false
    t.boolean "detached"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_cutomer_learn_mods_on_customer_id"
    t.index ["learn_mod_id"], name: "index_cutomer_learn_mods_on_learn_mod_id"
  end

  create_table "dialogic_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "email_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "file_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "global_skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "global_videos", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "wistia_code"
    t.integer "duration"
    t.integer "video_type"
    t.boolean "private"
    t.bigint "customer_id", null: false
    t.text "transcript"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_global_videos_on_customer_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "interstitial_contents", force: :cascade do |t|
    t.bigint "email_learn_obj_id", null: false
    t.integer "content_order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email_learn_obj_id"], name: "index_interstitial_contents_on_email_learn_obj_id"
  end

  create_table "jwt_blacklists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_jwt_blacklists_on_jti"
  end

  create_table "learn_mod_contributor_roles", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "learn_mod_contributors", force: :cascade do |t|
    t.bigint "learn_mod_contributor_role_id", null: false
    t.bigint "learn_mod_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learn_mod_contributor_role_id"], name: "index_learn_mod_contributors_on_learn_mod_contributor_role_id"
    t.index ["learn_mod_id"], name: "index_learn_mod_contributors_on_learn_mod_id"
    t.index ["user_id"], name: "index_learn_mod_contributors_on_user_id"
  end

  create_table "learn_mod_learning_objectives", force: :cascade do |t|
    t.bigint "learn_mod_id", null: false
    t.bigint "learning_objective_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learn_mod_id"], name: "index_learn_mod_learning_objectives_on_learn_mod_id"
    t.index ["learning_objective_id"], name: "index_learn_mod_learning_objectives_on_learning_objective_id"
  end

  create_table "learn_mod_organizations", force: :cascade do |t|
    t.boolean "is_learner_organization"
    t.text "abstract"
    t.bigint "learn_mod_id", null: false
    t.bigint "world_organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learn_mod_id"], name: "index_learn_mod_organizations_on_learn_mod_id"
    t.index ["world_organization_id"], name: "index_learn_mod_organizations_on_world_organization_id"
  end

  create_table "learn_mod_skills", force: :cascade do |t|
    t.bigint "learn_mod_id", null: false
    t.bigint "global_skill_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["global_skill_id"], name: "index_learn_mod_skills_on_global_skill_id"
    t.index ["learn_mod_id"], name: "index_learn_mod_skills_on_learn_mod_id"
  end

  create_table "learn_mods", force: :cascade do |t|
    t.string "name"
    t.integer "time_to_complete"
    t.text "abstract"
    t.bigint "world_id", null: false
    t.integer "intro_video_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["world_id"], name: "index_learn_mods_on_world_id"
  end

  create_table "learn_obj_characters", force: :cascade do |t|
    t.bigint "world_org_character_id", null: false
    t.integer "character_type"
    t.bigint "learning_object_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learning_object_id"], name: "index_learn_obj_characters_on_learning_object_id"
    t.index ["world_org_character_id"], name: "index_learn_obj_characters_on_world_org_character_id"
  end

  create_table "learning_objectives", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "learning_objects", force: :cascade do |t|
    t.string "name"
    t.bigint "learn_mod_id", null: false
    t.integer "card_order"
    t.integer "learning_object_type"
    t.string "objectable_type", null: false
    t.bigint "objectable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learn_mod_id"], name: "index_learning_objects_on_learn_mod_id"
    t.index ["objectable_type", "objectable_id"], name: "index_learning_objects_on_objectable_type_and_objectable_id"
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

  create_table "quiz_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "sections", force: :cascade do |t|
    t.bigint "cutomer_learn_mod_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cutomer_learn_mod_id"], name: "index_sections_on_cutomer_learn_mod_id"
  end

  create_table "slide_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "technical_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "text_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_learn_mods", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "section_id", null: false
    t.bigint "learn_mod_id", null: false
    t.datetime "time_started"
    t.datetime "time_completed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learn_mod_id"], name: "index_user_learn_mods_on_learn_mod_id"
    t.index ["section_id"], name: "index_user_learn_mods_on_section_id"
    t.index ["user_id"], name: "index_user_learn_mods_on_user_id"
  end

  create_table "user_learn_objs", force: :cascade do |t|
    t.bigint "user_learn_mod_id", null: false
    t.boolean "complete"
    t.bigint "learning_object_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learning_object_id"], name: "index_user_learn_objs_on_learning_object_id"
    t.index ["user_learn_mod_id"], name: "index_user_learn_objs_on_user_learn_mod_id"
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
    t.integer "customer_id"
    t.index ["customer_id"], name: "index_worlds_on_customer_id"
    t.index ["world_code"], name: "index_worlds_on_world_code", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cutomer_learn_mods", "customers"
  add_foreign_key "cutomer_learn_mods", "learn_mods"
  add_foreign_key "global_videos", "customers"
  add_foreign_key "interstitial_contents", "email_learn_objs"
  add_foreign_key "learn_mod_contributors", "learn_mod_contributor_roles"
  add_foreign_key "learn_mod_contributors", "learn_mods"
  add_foreign_key "learn_mod_contributors", "users"
  add_foreign_key "learn_mod_learning_objectives", "learn_mods"
  add_foreign_key "learn_mod_learning_objectives", "learning_objectives"
  add_foreign_key "learn_mod_organizations", "learn_mods"
  add_foreign_key "learn_mod_organizations", "world_organizations"
  add_foreign_key "learn_mod_skills", "global_skills"
  add_foreign_key "learn_mod_skills", "learn_mods"
  add_foreign_key "learn_mods", "worlds"
  add_foreign_key "learn_obj_characters", "learning_objects"
  add_foreign_key "learn_obj_characters", "world_org_characters"
  add_foreign_key "learning_objects", "learn_mods"
  add_foreign_key "organization_characters", "characters"
  add_foreign_key "organization_characters", "organizations"
  add_foreign_key "organization_characters", "world_roles"
  add_foreign_key "organizations", "industries"
  add_foreign_key "sections", "cutomer_learn_mods"
  add_foreign_key "user_learn_mods", "learn_mods"
  add_foreign_key "user_learn_mods", "sections"
  add_foreign_key "user_learn_mods", "users"
  add_foreign_key "user_learn_objs", "learning_objects"
  add_foreign_key "user_learn_objs", "user_learn_mods"
  add_foreign_key "world_org_characters", "characters"
  add_foreign_key "world_org_characters", "world_organizations"
  add_foreign_key "world_org_characters", "world_roles"
  add_foreign_key "world_organizations", "organizations"
  add_foreign_key "world_organizations", "worlds"
  add_foreign_key "worlds", "customers"
end
