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

ActiveRecord::Schema.define(version: 2020_07_11_091716) do

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

  create_table "answer_key_topic_evaluations", force: :cascade do |t|
    t.bigint "dialogic_answer_id", null: false
    t.bigint "key_topic_id", null: false
    t.bigint "dialogic_assmnt_item_id"
    t.bigint "missed_assmnt_item_id"
    t.float "points_earned"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dialogic_answer_id"], name: "index_answer_key_topic_evaluations_on_dialogic_answer_id"
    t.index ["dialogic_assmnt_item_id"], name: "index_answer_key_topic_evaluations_on_dialogic_assmnt_item_id"
    t.index ["key_topic_id"], name: "index_answer_key_topic_evaluations_on_key_topic_id"
    t.index ["missed_assmnt_item_id"], name: "index_answer_key_topic_evaluations_on_missed_assmnt_item_id"
  end

  create_table "assessment_labels", force: :cascade do |t|
    t.string "name"
    t.integer "order"
    t.bigint "assessment_scheme_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assessment_scheme_id"], name: "index_assessment_labels_on_assessment_scheme_id"
  end

  create_table "assessment_schemes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "assistant_dialog_skills", force: :cascade do |t|
    t.string "name"
    t.string "skill_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "learning_object_id"
    t.index ["learning_object_id"], name: "index_assistant_dialog_skills_on_learning_object_id"
  end

  create_table "asst_assistant_shells", force: :cascade do |t|
    t.integer "assistant_dialog_skill_id"
    t.string "name"
    t.string "assistant_id"
    t.text "url"
    t.text "api_key"
    t.string "credentials_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assistant_dialog_skill_id"], name: "index_asst_assistant_shells_on_assistant_dialog_skill_id"
  end

  create_table "asst_entities", force: :cascade do |t|
    t.string "name"
    t.bigint "learning_object_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "in_watson"
    t.index ["learning_object_id"], name: "index_asst_entities_on_learning_object_id"
  end

  create_table "asst_entity_val_synonyms", force: :cascade do |t|
    t.string "synonym"
    t.bigint "asst_entity_value_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "in_watson"
    t.index ["asst_entity_value_id"], name: "index_asst_entity_val_synonyms_on_asst_entity_value_id"
  end

  create_table "asst_entity_values", force: :cascade do |t|
    t.string "value"
    t.bigint "asst_entity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "in_watson"
    t.index ["asst_entity_id"], name: "index_asst_entity_values_on_asst_entity_id"
  end

  create_table "asst_intent_examples", force: :cascade do |t|
    t.text "example"
    t.bigint "asst_intent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["asst_intent_id"], name: "index_asst_intent_examples_on_asst_intent_id"
  end

  create_table "asst_intents", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "learning_object_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learning_object_id"], name: "index_asst_intents_on_learning_object_id"
  end

  create_table "asst_service_instances", force: :cascade do |t|
    t.bigint "learn_mod_id", null: false
    t.string "guid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learn_mod_id"], name: "index_asst_service_instances_on_learn_mod_id"
  end

  create_table "char_response_variations", force: :cascade do |t|
    t.text "response"
    t.bigint "email_response_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email_response_id"], name: "index_char_response_variations_on_email_response_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.integer "age"
    t.integer "gender_id"
    t.boolean "real_world", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "organizations_count", default: 0
  end

  create_table "chat_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.integer "chat_character_id", array: true
    t.integer "mentor_character_id"
    t.json "dialog_node_list"
  end

  create_table "chat_skill_assmnt_items", force: :cascade do |t|
    t.integer "assessment_label_id"
    t.integer "value_count_min"
    t.integer "value_count_max"
    t.float "points"
    t.integer "chat_skill_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assessment_label_id"], name: "index_chat_skill_assmnt_items_on_assessment_label_id"
    t.index ["chat_skill_id"], name: "index_chat_skill_assmnt_items_on_chat_skill_id"
  end

  create_table "chat_skill_assmnt_misseds", force: :cascade do |t|
    t.integer "chat_skill_id"
    t.float "points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_skill_id"], name: "index_chat_skill_assmnt_misseds_on_chat_skill_id"
  end

  create_table "chat_skills", force: :cascade do |t|
    t.integer "assistant_dialog_skill_id"
    t.string "skill_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assistant_dialog_skill_id"], name: "index_chat_skills_on_assistant_dialog_skill_id"
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

  create_table "debriefs", force: :cascade do |t|
    t.text "content"
    t.string "debriefable_type", null: false
    t.bigint "debriefable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["debriefable_type", "debriefable_id"], name: "index_debriefs_on_debriefable_type_and_debriefable_id"
  end

  create_table "dialogic_answers", force: :cascade do |t|
    t.bigint "dialogic_evaluation_id", null: false
    t.bigint "dialogic_question_id", null: false
    t.text "answer"
    t.boolean "evaluated", default: false
    t.boolean "follow_up_answer", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "character_response"
    t.text "follow_up_question"
    t.integer "question_variation_id"
    t.index ["dialogic_evaluation_id"], name: "index_dialogic_answers_on_dialogic_evaluation_id"
    t.index ["dialogic_question_id"], name: "index_dialogic_answers_on_dialogic_question_id"
  end

  create_table "dialogic_assmnt_items", force: :cascade do |t|
    t.bigint "key_topic_id", null: false
    t.bigint "assessment_label_id", null: false
    t.integer "value_count_min"
    t.integer "value_count_max"
    t.float "points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "have_follow_up_question", default: false
    t.index ["assessment_label_id"], name: "index_dialogic_assmnt_items_on_assessment_label_id"
    t.index ["key_topic_id"], name: "index_dialogic_assmnt_items_on_key_topic_id"
  end

  create_table "dialogic_debrief_evaluations", force: :cascade do |t|
    t.bigint "dialogic_evaluation_id", null: false
    t.bigint "key_topic_id", null: false
    t.integer "assessment_label_id"
    t.text "debrief_received"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "key_topic_missed", default: false
    t.float "kt_points"
    t.index ["assessment_label_id"], name: "index_dialogic_debrief_evaluations_on_assessment_label_id"
    t.index ["dialogic_evaluation_id"], name: "index_dialogic_debrief_evaluations_on_dialogic_evaluation_id"
    t.index ["key_topic_id"], name: "index_dialogic_debrief_evaluations_on_key_topic_id"
  end

  create_table "dialogic_evaluations", force: :cascade do |t|
    t.bigint "user_learn_obj_id", null: false
    t.bigint "overall_assmnt_item_id"
    t.float "overall_points"
    t.integer "repeat_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "complete", default: false
    t.integer "variation_order_ids", default: [], array: true
    t.index ["overall_assmnt_item_id"], name: "index_dialogic_evaluations_on_overall_assmnt_item_id"
    t.index ["user_learn_obj_id"], name: "index_dialogic_evaluations_on_user_learn_obj_id"
  end

  create_table "dialogic_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.integer "character_id"
    t.boolean "repeat_interaction", default: false
    t.integer "max_repeat_count"
    t.boolean "unlimited_repeats", default: false
    t.text "introduction"
    t.text "conclusion"
  end

  create_table "dialogic_questions", force: :cascade do |t|
    t.string "concept"
    t.text "question"
    t.integer "order"
    t.bigint "dialogic_learn_obj_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dialogic_learn_obj_id"], name: "index_dialogic_questions_on_dialogic_learn_obj_id"
  end

  create_table "dialogic_responses", force: :cascade do |t|
    t.bigint "dialogic_assmnt_item_id", null: false
    t.text "response"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dialogic_assmnt_item_id"], name: "index_dialogic_responses_on_dialogic_assmnt_item_id"
  end

  create_table "email_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.integer "to_character_ids", default: [], array: true
    t.integer "cc_character_ids", default: [], array: true
    t.text "email_body"
  end

  create_table "email_responses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "email_learn_obj_id", null: false
    t.index ["email_learn_obj_id"], name: "index_email_responses_on_email_learn_obj_id"
  end

  create_table "entity_evaluation_items", force: :cascade do |t|
    t.bigint "entity_evaluation_id", null: false
    t.bigint "asst_entity_value_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["asst_entity_value_id"], name: "index_entity_evaluation_items_on_asst_entity_value_id"
    t.index ["entity_evaluation_id"], name: "index_entity_evaluation_items_on_entity_evaluation_id"
  end

  create_table "entity_evaluations", force: :cascade do |t|
    t.text "condition"
    t.bigint "quiz_question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quiz_question_id"], name: "index_entity_evaluations_on_quiz_question_id"
  end

  create_table "file_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "global_resource_id", null: false
    t.index ["global_resource_id"], name: "index_file_learn_objs_on_global_resource_id"
  end

  create_table "follow_up_questions", force: :cascade do |t|
    t.text "question"
    t.float "points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "follow_up_able_type"
    t.bigint "follow_up_able_id"
    t.index ["follow_up_able_type", "follow_up_able_id"], name: "follow_up_able_index"
  end

  create_table "formula_asst_entity_values", force: :cascade do |t|
    t.bigint "asst_entity_value_id", null: false
    t.bigint "response_formula_id", null: false
    t.boolean "present_cond"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["asst_entity_value_id"], name: "index_formula_asst_entity_values_on_asst_entity_value_id"
    t.index ["response_formula_id"], name: "index_formula_asst_entity_values_on_response_formula_id"
  end

  create_table "formula_asst_intents", force: :cascade do |t|
    t.bigint "asst_intent_id", null: false
    t.bigint "response_formula_id", null: false
    t.boolean "present_cond"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["asst_intent_id"], name: "index_formula_asst_intents_on_asst_intent_id"
    t.index ["response_formula_id"], name: "index_formula_asst_intents_on_response_formula_id"
  end

  create_table "formula_emotions", force: :cascade do |t|
    t.integer "emotion"
    t.integer "comparator"
    t.float "score"
    t.boolean "present_cond"
    t.bigint "response_formula_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["response_formula_id"], name: "index_formula_emotions_on_response_formula_id"
  end

  create_table "formula_nlu_concepts", force: :cascade do |t|
    t.bigint "nlu_concept_id", null: false
    t.bigint "response_formula_id", null: false
    t.boolean "present_cond"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nlu_concept_id"], name: "index_formula_nlu_concepts_on_nlu_concept_id"
    t.index ["response_formula_id"], name: "index_formula_nlu_concepts_on_response_formula_id"
  end

  create_table "formula_nlu_entities", force: :cascade do |t|
    t.bigint "nlu_entity_id", null: false
    t.bigint "response_formula_id", null: false
    t.boolean "present_cond"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nlu_entity_id"], name: "index_formula_nlu_entities_on_nlu_entity_id"
    t.index ["response_formula_id"], name: "index_formula_nlu_entities_on_response_formula_id"
  end

  create_table "formula_nlu_keywords", force: :cascade do |t|
    t.bigint "nlu_keyword_id", null: false
    t.bigint "response_formula_id", null: false
    t.boolean "present_cond"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nlu_keyword_id"], name: "index_formula_nlu_keywords_on_nlu_keyword_id"
    t.index ["response_formula_id"], name: "index_formula_nlu_keywords_on_response_formula_id"
  end

  create_table "formula_sentiments", force: :cascade do |t|
    t.integer "sentiment"
    t.integer "comparator"
    t.float "score"
    t.boolean "present_cond"
    t.bigint "response_formula_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["response_formula_id"], name: "index_formula_sentiments_on_response_formula_id"
  end

  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "global_resources", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "resource_type"
    t.bigint "customer_id"
    t.boolean "private", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cached_tag_list"
    t.boolean "is_pdf", default: false
    t.index ["customer_id"], name: "index_global_resources_on_customer_id"
  end

  create_table "global_skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "global_videos", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "wistia_code"
    t.integer "duration"
    t.integer "video_type"
    t.boolean "private", default: false
    t.text "transcript"
    t.bigint "customer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cached_tag_list"
    t.string "wistia_thumbnail_url"
    t.string "file_name"
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

  create_table "key_topic_values", force: :cascade do |t|
    t.bigint "key_topic_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key_topic_id"], name: "index_key_topic_values_on_key_topic_id"
  end

  create_table "key_topics", force: :cascade do |t|
    t.bigint "dialogic_question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "asst_entity_id", null: false
    t.index ["asst_entity_id"], name: "index_key_topics_on_asst_entity_id"
    t.index ["dialogic_question_id"], name: "index_key_topics_on_dialogic_question_id"
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

  create_table "learn_mod_intro_docs", force: :cascade do |t|
    t.bigint "learn_mod_id", null: false
    t.bigint "global_resource_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["global_resource_id"], name: "index_learn_mod_intro_docs_on_global_resource_id"
    t.index ["learn_mod_id"], name: "index_learn_mod_intro_docs_on_learn_mod_id"
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
    t.integer "world_role_id"
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
    t.integer "unique_code", null: false
    t.integer "learning_objects_count", default: 0
    t.text "description"
    t.integer "lead_designer_id"
    t.integer "sme_id"
    t.text "learning_objectives"
    t.text "notes"
    t.string "cached_skill_list"
    t.integer "status", default: 0
    t.index ["unique_code"], name: "index_learn_mods_on_unique_code", unique: true
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

  create_table "learner_dashes", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "welcome_text", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.integer "status", default: 0
    t.datetime "archived_on"
    t.text "description"
    t.boolean "overall_assessment_required", default: false, null: false
    t.bigint "assessment_scheme_id"
    t.text "admin_notes"
    t.index ["assessment_scheme_id"], name: "index_learning_objects_on_assessment_scheme_id"
    t.index ["learn_mod_id"], name: "index_learning_objects_on_learn_mod_id"
    t.index ["objectable_type", "objectable_id"], name: "index_learning_objects_on_objectable_type_and_objectable_id"
  end

  create_table "mcq_options", force: :cascade do |t|
    t.integer "order"
    t.text "option"
    t.boolean "is_correct", default: false
    t.bigint "quiz_question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quiz_question_id"], name: "index_mcq_options_on_quiz_question_id"
  end

  create_table "missed_assmnt_items", force: :cascade do |t|
    t.bigint "key_topic_id", null: false
    t.boolean "has_follow_up_question"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key_topic_id"], name: "index_missed_assmnt_items_on_key_topic_id"
  end

  create_table "missed_responses", force: :cascade do |t|
    t.bigint "missed_assmnt_item_id", null: false
    t.text "response"
    t.boolean "follow_up", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["missed_assmnt_item_id"], name: "index_missed_responses_on_missed_assmnt_item_id"
  end

  create_table "nlu_concepts", force: :cascade do |t|
    t.bigint "learning_object_id", null: false
    t.string "concept"
    t.float "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learning_object_id"], name: "index_nlu_concepts_on_learning_object_id"
  end

  create_table "nlu_emotion_scores", force: :cascade do |t|
    t.bigint "learning_object_id", null: false
    t.float "sadness"
    t.float "joy"
    t.float "fear"
    t.float "disgust"
    t.float "anger"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "from_ideal_input"
    t.index ["learning_object_id"], name: "index_nlu_emotion_scores_on_learning_object_id"
  end

  create_table "nlu_entities", force: :cascade do |t|
    t.bigint "learning_object_id", null: false
    t.string "entity"
    t.string "entity_type"
    t.float "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learning_object_id"], name: "index_nlu_entities_on_learning_object_id"
  end

  create_table "nlu_keywords", force: :cascade do |t|
    t.bigint "learning_object_id", null: false
    t.string "keyword"
    t.float "relevance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learning_object_id"], name: "index_nlu_keywords_on_learning_object_id"
  end

  create_table "nlu_sentiments", force: :cascade do |t|
    t.bigint "learning_object_id", null: false
    t.integer "sentiment"
    t.float "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "from_ideal_input"
    t.index ["learning_object_id"], name: "index_nlu_sentiments_on_learning_object_id"
  end

  create_table "nlu_training_inputs", force: :cascade do |t|
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "learning_object_id", null: false
    t.index ["learning_object_id"], name: "index_nlu_training_inputs_on_learning_object_id"
  end

  create_table "numeric_answers", force: :cascade do |t|
    t.float "answer"
    t.bigint "quiz_question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quiz_question_id"], name: "index_numeric_answers_on_quiz_question_id"
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

  create_table "overall_assmnt_items", force: :cascade do |t|
    t.float "min_score"
    t.float "max_score"
    t.text "feedback"
    t.bigint "assessment_label_id", null: false
    t.bigint "learning_object_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assessment_label_id"], name: "index_overall_assmnt_items_on_assessment_label_id"
    t.index ["learning_object_id"], name: "index_overall_assmnt_items_on_learning_object_id"
  end

  create_table "question_variations", force: :cascade do |t|
    t.text "question"
    t.bigint "dialogic_question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dialogic_question_id"], name: "index_question_variations_on_dialogic_question_id"
  end

  create_table "quiz_evaluations", force: :cascade do |t|
    t.bigint "user_learn_obj_id", null: false
    t.boolean "quiz_submitted", default: false
    t.boolean "evaluated", default: false
    t.integer "point_type"
    t.float "points"
    t.bigint "overall_assmnt_item_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "quiz_complete", default: false
    t.integer "question_order_ids", default: [], array: true
    t.index ["overall_assmnt_item_id"], name: "index_quiz_evaluations_on_overall_assmnt_item_id"
    t.index ["user_learn_obj_id"], name: "index_quiz_evaluations_on_user_learn_obj_id"
  end

  create_table "quiz_feedbacks", force: :cascade do |t|
    t.text "right_ans_feedback"
    t.text "wrong_ans_feedback"
    t.bigint "quiz_question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quiz_question_id"], name: "index_quiz_feedbacks_on_quiz_question_id"
  end

  create_table "quiz_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.text "description"
    t.integer "score_view_type", default: 0, null: false
    t.boolean "overall_module_assessment_inclusion", default: false, null: false
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.text "question"
    t.integer "question_type"
    t.integer "points"
    t.integer "order"
    t.boolean "feedback_from_watson", default: false
    t.bigint "quiz_learn_obj_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "dialog_node_added", default: false
    t.index ["quiz_learn_obj_id"], name: "index_quiz_questions_on_quiz_learn_obj_id"
  end

  create_table "quiz_responses", force: :cascade do |t|
    t.text "response"
    t.integer "mcq_response_id"
    t.boolean "evaluated", default: false
    t.boolean "is_correct"
    t.float "points_earned"
    t.text "feedback_received"
    t.bigint "quiz_question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quiz_evaluation_id", null: false
    t.index ["quiz_evaluation_id"], name: "index_quiz_responses_on_quiz_evaluation_id"
    t.index ["quiz_question_id"], name: "index_quiz_responses_on_quiz_question_id"
  end

  create_table "range_answers", force: :cascade do |t|
    t.float "low_range"
    t.float "high_range"
    t.bigint "quiz_question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quiz_question_id"], name: "index_range_answers_on_quiz_question_id"
  end

  create_table "required_key_topic_values", force: :cascade do |t|
    t.bigint "dialogic_assmnt_item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "key_topic_value_id"
    t.index ["dialogic_assmnt_item_id"], name: "index_required_key_topic_values_on_dialogic_assmnt_item_id"
  end

  create_table "response_formulas", force: :cascade do |t|
    t.string "formula"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "email_response_id", null: false
    t.integer "present_cond_keyword_min"
    t.integer "absent_cond_keyword_min"
    t.index ["email_response_id"], name: "index_response_formulas_on_email_response_id"
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
    t.boolean "has_caption", default: true
  end

  create_table "slider_images", force: :cascade do |t|
    t.string "caption"
    t.bigint "slide_learn_obj_id", null: false
    t.bigint "global_resource_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["global_resource_id"], name: "index_slider_images_on_global_resource_id"
    t.index ["slide_learn_obj_id"], name: "index_slider_images_on_slide_learn_obj_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "technical_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "text_learn_objs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
  end

  create_table "user_chat_messages", force: :cascade do |t|
    t.text "learner_message"
    t.text "assistant_response"
    t.boolean "mentor", default: false, null: false
    t.integer "user_chat_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_chat_id"], name: "index_user_chat_messages_on_user_chat_id"
  end

  create_table "user_chats", force: :cascade do |t|
    t.integer "user_learn_obj_id"
    t.string "assistant_sessionid"
    t.text "assistant_session_json"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "character_starts_interaction", default: false, null: false
    t.index ["user_learn_obj_id"], name: "index_user_chats_on_user_learn_obj_id"
  end

  create_table "user_learn_objs", force: :cascade do |t|
    t.bigint "user_section_id", null: false
    t.boolean "complete", default: false
    t.bigint "learning_object_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "used_variation_ids", default: [], array: true
    t.index ["learning_object_id"], name: "index_user_learn_objs_on_learning_object_id"
    t.index ["user_section_id"], name: "index_user_learn_objs_on_user_section_id"
  end

  create_table "user_sections", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "section_id", null: false
    t.bigint "learn_mod_id", null: false
    t.datetime "time_started"
    t.datetime "time_completed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "completed_count", default: 0
    t.integer "status", default: 0
    t.integer "complete_percentage", default: 0
    t.index ["learn_mod_id"], name: "index_user_sections_on_learn_mod_id"
    t.index ["section_id"], name: "index_user_sections_on_section_id"
    t.index ["user_id"], name: "index_user_sections_on_user_id"
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

  create_table "video_learn_objs", force: :cascade do |t|
    t.bigint "global_video_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.index ["global_video_id"], name: "index_video_learn_objs_on_global_video_id"
  end

  create_table "world_global_resources", force: :cascade do |t|
    t.bigint "global_resource_id", null: false
    t.bigint "world_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["global_resource_id"], name: "index_world_global_resources_on_global_resource_id"
    t.index ["world_id"], name: "index_world_global_resources_on_world_id"
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

  create_table "world_videos", force: :cascade do |t|
    t.bigint "global_video_id", null: false
    t.bigint "world_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["global_video_id"], name: "index_world_videos_on_global_video_id"
    t.index ["world_id"], name: "index_world_videos_on_world_id"
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
  add_foreign_key "answer_key_topic_evaluations", "dialogic_answers"
  add_foreign_key "answer_key_topic_evaluations", "dialogic_assmnt_items"
  add_foreign_key "answer_key_topic_evaluations", "key_topics"
  add_foreign_key "answer_key_topic_evaluations", "missed_assmnt_items"
  add_foreign_key "assessment_labels", "assessment_schemes"
  add_foreign_key "asst_entities", "learning_objects"
  add_foreign_key "asst_entity_val_synonyms", "asst_entity_values"
  add_foreign_key "asst_entity_values", "asst_entities"
  add_foreign_key "asst_intent_examples", "asst_intents"
  add_foreign_key "asst_intents", "learning_objects"
  add_foreign_key "asst_service_instances", "learn_mods"
  add_foreign_key "char_response_variations", "email_responses"
  add_foreign_key "cutomer_learn_mods", "customers"
  add_foreign_key "cutomer_learn_mods", "learn_mods"
  add_foreign_key "dialogic_answers", "dialogic_evaluations"
  add_foreign_key "dialogic_answers", "dialogic_questions"
  add_foreign_key "dialogic_assmnt_items", "assessment_labels"
  add_foreign_key "dialogic_assmnt_items", "key_topics"
  add_foreign_key "dialogic_debrief_evaluations", "assessment_labels"
  add_foreign_key "dialogic_debrief_evaluations", "dialogic_evaluations"
  add_foreign_key "dialogic_debrief_evaluations", "key_topics"
  add_foreign_key "dialogic_evaluations", "overall_assmnt_items"
  add_foreign_key "dialogic_evaluations", "user_learn_objs"
  add_foreign_key "dialogic_questions", "dialogic_learn_objs"
  add_foreign_key "dialogic_responses", "dialogic_assmnt_items"
  add_foreign_key "email_responses", "email_learn_objs"
  add_foreign_key "entity_evaluation_items", "asst_entity_values"
  add_foreign_key "entity_evaluation_items", "entity_evaluations"
  add_foreign_key "entity_evaluations", "quiz_questions"
  add_foreign_key "file_learn_objs", "global_resources"
  add_foreign_key "formula_asst_entity_values", "asst_entity_values"
  add_foreign_key "formula_asst_entity_values", "response_formulas"
  add_foreign_key "formula_asst_intents", "asst_intents"
  add_foreign_key "formula_asst_intents", "response_formulas"
  add_foreign_key "formula_emotions", "response_formulas"
  add_foreign_key "formula_nlu_concepts", "nlu_concepts"
  add_foreign_key "formula_nlu_concepts", "response_formulas"
  add_foreign_key "formula_nlu_entities", "nlu_entities"
  add_foreign_key "formula_nlu_entities", "response_formulas"
  add_foreign_key "formula_nlu_keywords", "nlu_keywords"
  add_foreign_key "formula_nlu_keywords", "response_formulas"
  add_foreign_key "formula_sentiments", "response_formulas"
  add_foreign_key "global_resources", "customers"
  add_foreign_key "global_videos", "customers"
  add_foreign_key "interstitial_contents", "email_learn_objs"
  add_foreign_key "key_topic_values", "key_topics"
  add_foreign_key "key_topics", "asst_entities"
  add_foreign_key "key_topics", "dialogic_questions"
  add_foreign_key "learn_mod_contributors", "learn_mod_contributor_roles"
  add_foreign_key "learn_mod_contributors", "learn_mods"
  add_foreign_key "learn_mod_contributors", "users"
  add_foreign_key "learn_mod_intro_docs", "global_resources"
  add_foreign_key "learn_mod_intro_docs", "learn_mods"
  add_foreign_key "learn_mod_learning_objectives", "learn_mods"
  add_foreign_key "learn_mod_learning_objectives", "learning_objectives"
  add_foreign_key "learn_mod_organizations", "learn_mods"
  add_foreign_key "learn_mod_organizations", "world_organizations"
  add_foreign_key "learn_mod_skills", "global_skills"
  add_foreign_key "learn_mod_skills", "learn_mods"
  add_foreign_key "learn_mods", "worlds"
  add_foreign_key "learn_obj_characters", "learning_objects"
  add_foreign_key "learn_obj_characters", "world_org_characters"
  add_foreign_key "learning_objects", "assessment_schemes"
  add_foreign_key "learning_objects", "learn_mods"
  add_foreign_key "mcq_options", "quiz_questions"
  add_foreign_key "missed_assmnt_items", "key_topics"
  add_foreign_key "missed_responses", "missed_assmnt_items"
  add_foreign_key "nlu_concepts", "learning_objects"
  add_foreign_key "nlu_emotion_scores", "learning_objects"
  add_foreign_key "nlu_entities", "learning_objects"
  add_foreign_key "nlu_keywords", "learning_objects"
  add_foreign_key "nlu_sentiments", "learning_objects"
  add_foreign_key "nlu_training_inputs", "learning_objects"
  add_foreign_key "numeric_answers", "quiz_questions"
  add_foreign_key "organization_characters", "characters"
  add_foreign_key "organization_characters", "organizations"
  add_foreign_key "organization_characters", "world_roles"
  add_foreign_key "organizations", "industries"
  add_foreign_key "overall_assmnt_items", "assessment_labels"
  add_foreign_key "overall_assmnt_items", "learning_objects"
  add_foreign_key "question_variations", "dialogic_questions"
  add_foreign_key "quiz_evaluations", "overall_assmnt_items"
  add_foreign_key "quiz_evaluations", "user_learn_objs"
  add_foreign_key "quiz_feedbacks", "quiz_questions"
  add_foreign_key "quiz_questions", "quiz_learn_objs"
  add_foreign_key "quiz_responses", "quiz_evaluations"
  add_foreign_key "quiz_responses", "quiz_questions"
  add_foreign_key "range_answers", "quiz_questions"
  add_foreign_key "required_key_topic_values", "dialogic_assmnt_items"
  add_foreign_key "response_formulas", "email_responses"
  add_foreign_key "sections", "cutomer_learn_mods"
  add_foreign_key "slider_images", "global_resources"
  add_foreign_key "slider_images", "slide_learn_objs"
  add_foreign_key "taggings", "tags"
  add_foreign_key "user_learn_objs", "learning_objects"
  add_foreign_key "user_learn_objs", "user_sections"
  add_foreign_key "user_sections", "learn_mods"
  add_foreign_key "user_sections", "sections"
  add_foreign_key "user_sections", "users"
  add_foreign_key "video_learn_objs", "global_videos"
  add_foreign_key "world_global_resources", "global_resources"
  add_foreign_key "world_global_resources", "worlds"
  add_foreign_key "world_org_characters", "characters"
  add_foreign_key "world_org_characters", "world_organizations"
  add_foreign_key "world_org_characters", "world_roles"
  add_foreign_key "world_organizations", "organizations"
  add_foreign_key "world_organizations", "worlds"
  add_foreign_key "world_videos", "global_videos"
  add_foreign_key "world_videos", "worlds"
  add_foreign_key "worlds", "customers"
end
