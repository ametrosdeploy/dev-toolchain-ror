# frozen_string_literal: true

class OrganizationCharacterSerializer
  include FastJsonapi::ObjectSerializer
  attributes :world_role_id, :character_id, :organization_id

  attribute :world_role do |organization_character|
    WorldRoleSerializer.new(organization_character.world_role).as_json['data']
  end

  attribute :characters do |organization_character|
    CharacterSerializer.new(organization_character.character).as_json['data']
  end
end
