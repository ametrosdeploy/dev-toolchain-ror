class WorldOrganizationTrimmedSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  include DateHelper

  attribute :org_name do |world_org|
    world_org.organization.name
  end

  attribute :org_photo_url do |world_org|
    image_url(world_org.organization.photo)
  end

  attribute :industry_name do |world_org|
    world_org.organization.industry.try(:name)
  end

end
