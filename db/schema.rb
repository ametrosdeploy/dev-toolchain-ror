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

ActiveRecord::Schema.define(version: 2020_04_03_135204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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
    t.string "first_name"
    t.string "last_name"
    t.string "age"
    t.string "gender"
    t.string "real_world"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chat_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.text "title"
    t.text "description"
    t.text "wistia_code"
    t.integer "duration"
    t.integer "video_type"
    t.boolean "private"
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_global_videos_on_customer_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "learn_mod_contributor_roles", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "learn_mod_contributors", force: :cascade do |t|
    t.bigint "learn_mod_id", null: false
    t.bigint "user_id", null: false
    t.bigint "learn_mod_contributor_role_id", null: false
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
    t.bigint "learn_mod_id", null: false
    t.boolean "is_learner_organization"
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

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "real_world"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
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

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
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

  create_table "video_learn_objs", force: :cascade do |t|
    t.bigint "global_video_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["global_video_id"], name: "index_video_learn_objs_on_global_video_id"
  end

  create_table "world_org_characters", force: :cascade do |t|
    t.bigint "world_org_role_id", null: false
    t.bigint "character_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["character_id"], name: "index_world_org_characters_on_character_id"
    t.index ["world_org_role_id"], name: "index_world_org_characters_on_world_org_role_id"
  end

  create_table "world_org_roles", force: :cascade do |t|
    t.bigint "world_organization_id", null: false
    t.bigint "world_role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["world_organization_id"], name: "index_world_org_roles_on_world_organization_id"
    t.index ["world_role_id"], name: "index_world_org_roles_on_world_role_id"
  end

  create_table "world_organizations", force: :cascade do |t|
    t.bigint "world_id", null: false
    t.bigint "organization_id", null: false
    t.bigint "industry_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["industry_id"], name: "index_world_organizations_on_industry_id"
    t.index ["organization_id"], name: "index_world_organizations_on_organization_id"
    t.index ["world_id"], name: "index_world_organizations_on_world_id"
  end

  create_table "world_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "world_videos", force: :cascade do |t|
    t.bigint "world_id", null: false
    t.bigint "global_video_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["global_video_id"], name: "index_world_videos_on_global_video_id"
    t.index ["world_id"], name: "index_world_videos_on_world_id"
  end

  create_table "worlds", force: :cascade do |t|
    t.string "name"
    t.string "world_code"
    t.boolean "private"
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_worlds_on_customer_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "global_videos", "customers"
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
  add_foreign_key "learning_objects", "learn_mods"
  add_foreign_key "video_learn_objs", "global_videos"
  add_foreign_key "world_org_characters", "characters"
  add_foreign_key "world_org_characters", "world_org_roles"
  add_foreign_key "world_org_roles", "world_organizations"
  add_foreign_key "world_org_roles", "world_roles"
  add_foreign_key "world_organizations", "industries"
  add_foreign_key "world_organizations", "organizations"
  add_foreign_key "world_organizations", "worlds"
  add_foreign_key "world_videos", "global_videos"
  add_foreign_key "world_videos", "worlds"
  add_foreign_key "worlds", "customers"
end
