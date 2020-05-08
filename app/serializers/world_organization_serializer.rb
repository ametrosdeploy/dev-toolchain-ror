class WorldOrganizationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :world_id, :organization_id

  attribute :organization_character do |world_organization|
    OrganizationCharacterSerializer.new(world_organization.organization.organization_characters).as_json["data"]
  end

  attribute :world_org_characters do |world_organization|
    WordOrgCharacterSerializer.new(world_organization.world_org_characters).as_json["data"]
  end
end
