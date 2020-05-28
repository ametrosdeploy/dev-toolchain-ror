# frozen_string_literal: true

FactoryBot.define do
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

  factory :quiz_question do
    question { "MyText" }
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
