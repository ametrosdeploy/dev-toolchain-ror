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
