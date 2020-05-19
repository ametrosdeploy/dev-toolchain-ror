# frozen_string_literal: true

class WorldOrganizationCustomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :world_id, :organization_id

  attribute :organization do |world_organization|
    OrganizationSerializer.new(world_organization.organization).as_json['data']
  end

  attribute :organization_character do |world_organization|
    list = world_organization.world_org_characters.pluck(:character_id)
    org_char_list = world_organization.organization.organization_characters
                                      .limited_org_chars(list)
    OrganizationCharacterSerializer.new(org_char_list).as_json['data']
  end

  attribute :world_org_characters do |world_organization|
    WordOrgCharacterSerializer.new(world_organization.world_org_characters)
                              .as_json['data']
  end
end
