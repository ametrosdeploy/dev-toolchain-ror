# == Schema Information
#
# Table name: world_organizations
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  world_id        :bigint           not null
#
# Indexes
#
#  index_world_organizations_on_organization_id  (organization_id)
#  index_world_organizations_on_world_id         (world_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (world_id => worlds.id)
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
