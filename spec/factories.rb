FactoryBot.define do
  factory :world_org_character do
    character_id { 1 }
    world_organization_id { 1 }
    character_ { 'MyString' }
    role { 'MyString' }
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
