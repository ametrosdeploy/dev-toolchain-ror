# frozen_string_literal: true

# WorldOrgCharacter with less data
class WorldOrgCharacterTrimmedSerializer
  include FastJsonapi::ObjectSerializer
  include DateHelper
  attributes :character_id

  attribute :org_name do |world_org_character|
    world_org_character.world_organization.organization.name
  end

  attribute :world_role do |world_org_character|
    world_org_character.world_role.name
  end

  attribute :char_full_name do |world_org_character|
    world_org_character.character.full_name
  end

  attribute :char_gender do |world_org_character|
    world_org_character.character.gender_name
  end

  attribute :char_photo_url do |world_org_character|
    world_org_character.character.attachement_variations
  end

  attribute :char_age do |world_org_character|
    world_org_character.character.formatted_age
  end
end
