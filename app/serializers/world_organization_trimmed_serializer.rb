# frozen_string_literal: true

# WorldOrganization serializer with less data
class WorldOrganizationTrimmedSerializer
  include FastJsonapi::ObjectSerializer
  include DateHelper

  attribute :org_name do |world_org|
    world_org.organization.name
  end

  attribute :org_photo_url do |world_org|
    world_org.organization.attachement_variations
  end

  attribute :industry_name do |world_org|
    world_org.organization.industry.try(:name)
  end
end
