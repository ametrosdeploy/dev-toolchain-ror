# frozen_string_literal: true

FactoryBot.define do
  factory :user_chat_message do
    learner_message { "MyText" }
    assistant_response { "MyText" }
    mentor { false }
    user_chat_id { 1 }
  end

  factory :user_chat do
    user_learn_obj_id { 1 }
    assistant_sessionid { "MyString" }
    assistant_session_json { "MyText" }
  end

  factory :asst_assistant_shell do
    dialog_skill_id { 1 }
    name { "MyString" }
    guid { "MyString" }
    url { "MyText" }
    api_key { "MyText" }
    credentials_name { "MyString" }
  end

  factory :nlu_sentiment do
    learning_object { nil }
    sentiment { '' }
    score { 1.5 }
  end

  factory :nlu_emotion_score do
    learning_object { nil }
    sadness { 1.5 }
    joy { 1.5 }
    fear { 1.5 }
    disgust { 1.5 }
    anger { 1.5 }
  end

  factory :nlu_concept do
    learning_object { nil }
    concept { 'MyString' }
    score { 1.5 }
  end

  factory :nlu_entity do
    learning_object { nil }
    entity { 'MyString' }
    type { '' }
    score { 1.5 }
  end

  factory :nlu_keyword do
    learning_object { nil }
    keyword { 'MyString' }
    relevance { 1.5 }
  end

  factory :nlu_training_input do
    message { 'MyText' }
    email_learn_obj { nil }
  end

  factory :dialogic_debrief_evaluation do
    dialogic_evaluation { nil }
    key_topic { nil }
    assessment_label { nil }
    debrief_received { 'MyText' }
  end

  factory :answer_key_topic_evaluation do
    dialogic_answer { nil }
    key_topic { nil }
    dialogic_assmnt_item { nil }
    missed_assmnt_item { nil }
    points_earned { 1.5 }
  end

  factory :dialogic_answer do
    dialogic_evaluation { nil }
    dialogic_question { nil }
    answer { 'MyText' }
    evaluated { false }
    follow_up_answer { false }
  end

  factory :dialogic_evaluation do
    user_learn_obj { nil }
    overall_assmnt_item { nil }
    overall_points { 1.5 }
    repeat_count { 1 }
  end

  factory :debrief do
    content { 'MyText' }
    debriefable { nil }
  end

  factory :missed_response do
    missed_assmnt_item { nil }
    response { 'MyText' }
    follow_up { false }
  end

  factory :missed_assmnt_item do
    key_topic { nil }
    has_follow_up_question { false }
  end

  factory :gender do
    name { 'MyString' }
  end

  factory :quiz_evaluation do
    user_learn_obj { nil }
    quiz_submitted { false }
    evaluated { false }
    point_type { 1 }
    points { 1.5 }
    overall_assmnt_item { nil }
  end

  factory :dialogic_response do
    dialogic_assmnt_item { nil }
    response { 'MyText' }
  end

  factory :required_key_topic_value do
    dialogic_assmnt_item { nil }
    key_topic_value { nil }
  end

  factory :follow_up_question do
    dialogic_assmnt_item { nil }
    question { 'MyText' }
    points { 1.5 }
  end

  factory :dialogic_assmnt_item do
    key_topic { nil }
    assessment_label { nil }
    value_count_min { 1 }
    value_count_max { 1 }
    points { 1.5 }
  end

  factory :key_topic_value do
    key_topic { nil }
  end

  factory :key_topic do
    dialogic_question { nil }
  end

  factory :question_variation do
    question { 'MyText' }
    dialogic_question { nil }
  end

  factory :dialogic_question do
    concept { 'MyString' }
    question { 'MyText' }
    order { 1 }
    dialogic_learn_obj { nil }
  end

  factory :quiz_response do
    response { 'MyText' }
    mcq_response_id { 1 }
    evaluated { false }
    is_correct { false }
    points_earned { 1.5 }
    user_learn_obj { nil }
    quiz_question { nil }
  end

  factory :asst_service_instance do
    learn_mod { nil }
    guid { 'MyString' }
  end

  factory :overall_assmnt_item do
    min_score { 1.5 }
    max_score { 1.5 }
    feedback { 'MyText' }
    assessment_label { nil }
    learning_object { nil }
  end

  factory :assessment_label do
    name { 'MyString' }
    order { 1 }
    assessment_scheme { nil }
  end

  factory :assessment_scheme do
    name { 'MyString' }
  end

  factory :entity_evaluation do
    condition { 'MyText' }
    quiz_question { nil }
  end

  factory :asst_intent_example do
    example { 'MyText' }
    asst_intent { nil }
  end

  factory :asst_intent do
    name { 'MyString' }
    description { 'MyText' }
    learning_object { nil }
  end

  factory :asst_entity do
    name { 'MyString' }
    learning_object { nil }
  end

  factory :asst_entity_value do
    value { 'MyString' }
    asst_entity { nil }
  end

  factory :asst_entity_val_synonym do
    synonym { 'MyString' }
    asst_entity_value { nil }
  end

  factory :assistant_dialog_skill do
    name { 'MyString' }
    skill_id { 'MyString' }
    skillable { nil }
  end

  factory :learner_dash do
    title { 'MyString' }
    description { 'MyText' }
    welcome_text { 'MyString' }
  end

  factory :slider_image do
    caption { 'MyString' }
    slide_learn_obj { nil }
    global_resource { nil }
  end

  factory :range_answer do
    low_range { 1.5 }
    high_range { 1.5 }
    quiz_question { nil }
  end

  factory :numeric_answer do
    answer { 1.5 }
    quiz_question { nil }
  end

  factory :quiz_feedback do
    right_ans_feedback { 'MyText' }
    wrong_ans_feedback { 'MyText' }
    quiz_question { nil }
  end

  factory :mcq_option do
    order { '' }
    option { 'MyText' }
    is_correct { false }
    quiz_question { nil }
  end

  factory :quiz_question do
    question { 'MyText' }
    type { 1 }
    points { 1 }
    order { 1 }
    feedback_from_watson { false }
    quiz_learn_obj { nil }
  end

  factory :learn_mod_intro_doc do
    learn_mod { nil }
    global_resource { nil }
  end

  factory :world_global_resource do
    global_resource { nil }
    world { nil }
  end

  factory :global_resource do
    title { 'MyString' }
    description { 'MyText' }
    resource_type { 1 }
    customer { nil }

    # private { false }
  end

  factory :world_video do
    global_video { nil }
    world { nil }
  end

  factory :global_video do
    title { 'MyString' }
    description { 'MyText' }
    wistia_code { 'MyString' }
    duration { 1 }
    video_type { 1 }

    private { false }

    customer { nil }
    transcript { 'MyText' }
  end

  factory :learn_obj_character do
    world_org_character { nil }
    character_type { 1 }
    learning_object { nil }
  end

  factory :user_learn_obj do
    user_learn_mod { nil }
    complete { false }
    learning_object { nil }
  end

  factory :user_learn_mod do
    user { nil }
    section { nil }
    learn_mod { nil }
    time_started { '2020-05-06 23:48:42' }
    time_completed { '2020-05-06 23:48:42' }
  end

  factory :section do
    cutomer_learn_mod { nil }
  end

  factory :cutomer_learn_mod do
    customer { nil }
    learn_mod { nil }
    detached { false }
  end

  factory :interstitial_content do
    email_learn_obj { nil }
    content_order { 1 }
  end

  factory :learn_mod_skill do
    learn_mod { nil }
    global_skill { nil }
  end

  factory :file_learn_obj do
  end

  factory :slide_learn_obj do
  end

  factory :video_learn_obj do
    global_video { nil }
  end

  factory :text_learn_obj do
  end

  factory :technical_learn_obj do
  end

  factory :quiz_learn_obj do
  end

  factory :dialogic_learn_obj do
  end

  factory :email_learn_obj do
  end

  factory :chat_learn_obj do
  end

  factory :learning_object do
    name { 'MyString' }
    learn_mod { nil }
    card_order { 1 }
    learning_object_type { 1 }
    objectable { nil }
  end

  factory :learn_mod_learning_objective do
    learn_mod { nil }
    learning_objective { nil }
  end

  factory :learn_mod_contributor do
    learn_mod_contributor_role { nil }
    learn_mod { nil }
    user { nil }
  end

  factory :learn_mod_contributor_role do
    title { 'MyString' }
  end

  factory :learn_mod_organization do
    is_learner_organization { false }
    abstract { 'MyText' }
    learn_mod { nil }
    world_organization { nil }
  end

  factory :learn_mod do
    name { 'MyString' }
    time_to_complete { 1 }
    abstract { 'MyText' }
    world { nil }
    intro_video_id { 1 }
  end

  factory :global_skill do
    name { 'MyString' }
  end

  factory :learning_objective do
    name { 'MyString' }
    description { 'MyText' }
  end

  factory :organization_character do
    character { nil }
    organization { nil }
    world_role { nil }
  end

  factory :world_role do
    name { 'MyString' }
  end

  factory :world_org_character do
    character_id { 1 }
    world_organization_id { 1 }
  end

  factory :industry do
    name { 'MyString' }
  end

  factory :world_organization do
    world_id { 1 }
    organization_id { 1 }
    industry_id { 1 }
  end

  factory :organization do
    name { 'MyString' }
    description { 'MyText' }
    real_world { false }
  end

  factory :customer do
    name { 'MyString' }
    email { 'MyString' }
  end

  factory :world do
    name { 'MyString' }
    description { 'MyText' }
    customer_id { 1 }
    world_code { 'MyString' }
    is_private { false }
  end

  factory :character do
    first_name { 'MyString' }
    last_name { 'MyString' }
    age { 1 }
    gender { 1 }
    real_world { false }
  end
end
