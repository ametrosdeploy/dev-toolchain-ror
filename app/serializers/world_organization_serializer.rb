# == Schema Information
#
# Table name: world_organizations
#
#  id              :bigint           not null, primary key
#  world_id        :bigint           not null
#  organization_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class WorldOrganizationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :world_id, :organization_id

  attribute :organization do |world_organization|
    OrganizationSerializer.new(world_organization.organization).as_json["data"]
  end

  attribute :characters do |world_organization|
    CharacterSerializer.new(world_organization.characters).as_json["data"]
  end
end
