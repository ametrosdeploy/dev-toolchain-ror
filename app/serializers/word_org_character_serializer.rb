class WordOrgCharacterSerializer
  include FastJsonapi::ObjectSerializer
  
  attribute :world_role do |world_org_character|
    WorldRoleSerializer.new(world_org_character.world_role).as_json["data"]
  end
  attribute :character do |world_org_character|
    CharacterSerializer.new(world_org_character.character).as_json["data"]
  end
end
