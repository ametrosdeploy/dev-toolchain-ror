FactoryBot.define do
  factory :chat_learn_obj do
    administrative_notes { "MyText" }
    chat_character_id { 1 }
    mentor_character_id { 1 }
  end
  
  factory :dialogic_interaction do
    name { "MyString" }
    card_order { 1 }
  end

  factory :email_interaction do
    card_order { 1 }
    next_chain_id { "" }
    name { "MyString" }
  end

  factory :learning_object do
    learning_module { nil }
    learning_object_type { 1 }
  end

  factory :learning_module do
    name { "MyString" }
    time_to_complete { 1 }
    abstract { "MyText" }
    world { nil }
  end

  factory :organization_character do
    character { nil }
    organization { nil }
    world_role { nil }
  end

  factory :world_role do
    name { "MyString" }
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
